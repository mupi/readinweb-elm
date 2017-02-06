module App.Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
<<<<<<< c145ca3b6b3d82aded783fdd7b3730d07f1d7a36
import User.Types as User
import Question.Types as Question
=======
import User.Type as User
import Debug
>>>>>>> Add login/logout matchers in routing


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
<<<<<<< c145ca3b6b3d82aded783fdd7b3730d07f1d7a36
        , map QuestionRoute (s "questions" </> int)
=======
>>>>>>> Add login/logout matchers in routing
        , map LoginRoute (s "login")
        ]


loginMatchers : Parser (Route -> a) a
loginMatchers =
    oneOf
        [ map Index top
        , map Index (s "index")
        , map Index (s "login")
<<<<<<< c145ca3b6b3d82aded783fdd7b3730d07f1d7a36
        , map QuestionRoute (s "questions" </> int)
=======
>>>>>>> Add login/logout matchers in routing
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
