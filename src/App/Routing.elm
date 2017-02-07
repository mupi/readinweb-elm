module App.Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import User.Types as User
import Question.Types as Question


type Route
    = Index
    | UsersRoute
    | LoginRoute
    | QuestionRoute Question.QuestionId
    | NotFoundRote


normalMatchers : Parser (Route -> a) a
normalMatchers =
    oneOf
        [ map Index top
        , map Index (s "index")
        , map QuestionRoute (s "questions" </> int)
        , map LoginRoute (s "login")
        ]


loginMatchers : Parser (Route -> a) a
loginMatchers =
    oneOf
        [ map Index top
        , map Index (s "index")
        , map Index (s "login")
        , map QuestionRoute (s "questions" </> int)
        , map UsersRoute (s "users")
        ]


parseLocation : Maybe a -> Location -> Route
parseLocation user location =
    let
        one =
            Debug.log "location" location
    in
        case user of
            Just user ->
                case (parseHash loginMatchers location) of
                    Just route ->
                        route

                    Nothing ->
                        NotFoundRote

            Nothing ->
                case (parseHash normalMatchers location) of
                    Just route ->
                        route

                    Nothing ->
                        NotFoundRote
