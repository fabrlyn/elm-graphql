module Graphql.PaginatorSetup exposing (CurrentPage, PageInfo, PaginatedData, PaginatorSetup(..), addPageInfo)

import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))


type alias PaginatedData data cursor =
    { data : List data
    , currentPage : CurrentPage cursor
    }


type alias PageInfo pageInfo cursor =
    { pageInfo
        | first : OptionalArgument Int
        , last : OptionalArgument Int
        , before : OptionalArgument cursor
        , after : OptionalArgument cursor
    }


{-| TODO
-}
addPageInfo : Maybe cursor -> PaginatorSetup -> PageInfo pageInfo cursor -> PageInfo pageInfo cursor
addPageInfo maybeCursor paginationSetup optionals =
    case paginationSetup of
        Forward { first } ->
            { optionals
                | first = Present first
                , after = OptionalArgument.fromMaybe maybeCursor
            }

        Backward { last } ->
            { optionals
                | last = Present last
                , before = OptionalArgument.fromMaybe maybeCursor
            }


{-| Uses [the relay protocol](https://facebook.github.io/relay/graphql/connections.htm).
-}
type PaginatorSetup
    = Forward { first : Int }
    | Backward { last : Int }


type alias CurrentPage cursorType =
    { cursor : Maybe cursorType
    , done : Bool
    }