module Graphqelm.Generator.ModuleName exposing (enum, enumTypeName, generate, interface, mutation, object, query, union)

import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Normalize as Normalize
import Graphqelm.Parser.Type as Type exposing (TypeDefinition(TypeDefinition))


generate : Context -> TypeDefinition -> List String
generate context (Type.TypeDefinition name definableType description) =
    case definableType of
        Type.ObjectType fields ->
            if name == context.query then
                query context
            else if Just name == context.mutation then
                mutation context
            else
                object context name

        Type.ScalarType ->
            []

        Type.EnumType enumValues ->
            enum context name

        Type.InterfaceType fields possibleTypes ->
            interface context name

        Type.UnionType possibleTypes ->
            union context name


object : Context -> String -> List String
object { query, mutation, apiSubmodule } name =
    if name == query then
        [ "RootQuery" ]
    else if Just name == mutation then
        [ "RootMutation" ]
    else
        apiSubmodule ++ [ "Object", Normalize.moduleName name ]


interface : Context -> String -> List String
interface { apiSubmodule } name =
    apiSubmodule ++ [ "Interface", Normalize.moduleName name ]


union : Context -> String -> List String
union { apiSubmodule } name =
    apiSubmodule ++ [ "Union", Normalize.moduleName name ]


enum : { context | apiSubmodule : List String } -> String -> List String
enum { apiSubmodule } name =
    apiSubmodule ++ [ "Enum", Normalize.moduleName name ]


enumTypeName : { context | apiSubmodule : List String } -> String -> List String
enumTypeName { apiSubmodule } name =
    apiSubmodule ++ [ "Enum", Normalize.moduleName name, Normalize.moduleName name ]


query : { context | apiSubmodule : List String } -> List String
query { apiSubmodule } =
    apiSubmodule ++ [ "Query" ]


mutation : { context | apiSubmodule : List String } -> List String
mutation { apiSubmodule } =
    apiSubmodule ++ [ "Mutation" ]
