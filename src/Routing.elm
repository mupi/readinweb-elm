module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Debug


type Route
    = Index
    | UsersRoute
    | LoginRoute
    | NotFoundRote


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Index top
        , map UsersRoute (s "users")
        , map LoginRoute (s "login")
        ]


parseLocation : Location -> Route
parseLocation location =
    let
        one =
            Debug.log "location" location
    in
        case (parseHash matchers location) of
            Just route ->
                route

            Nothing ->
                NotFoundRote
