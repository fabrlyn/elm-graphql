module Github.Object.GitActor exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.GitActor
selection constructor =
    Object.object constructor


avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Github.Object.GitActor
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


date : FieldDecoder String Github.Object.GitActor
date =
    Object.fieldDecoder "date" [] Decode.string


email : FieldDecoder String Github.Object.GitActor
email =
    Object.fieldDecoder "email" [] Decode.string


name : FieldDecoder String Github.Object.GitActor
name =
    Object.fieldDecoder "name" [] Decode.string


user : SelectionSet user Github.Object.User -> FieldDecoder user Github.Object.GitActor
user object =
    Object.single "user" [] object