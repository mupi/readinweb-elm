module Register.State exposing (init, update)

import Task exposing (Task)
import HttpBuilder
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Array exposing (..)


-- My Modules

import Register.Type exposing (..)
import User.Type as User
import User.State as User


init : Model
init =
    Model "" User.init


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetUsername username ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetUsername username) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        SetName name ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetName name) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        SetEmail email ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetEmail email) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        SetPassword password ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetPassword password) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        ClickRegisterUser ->
            ( model, registerUserCmd model registerUrl )

        RegisterSuccess sucesso ->
            let
                newUser =
                    User.Model model.user.username
                        model.user.email
                        model.user.name
                        model.user.password
                        sucesso.data
            in
                ( { model | user = newUser }, Cmd.none )

        RegisterError error ->
            ( { model | error = toString error }, Cmd.none )



-- GetUserSuccess token ->
--     ( model, Cmd.none )
-- ( { model
--     | token = token.data
--   }
-- , Cmd.none
-- )
-- UserError error ->
--     ( model, Cmd.none )
--     let
--         errorText =
--             case error of
--                 HttpBuilder.BadResponse response ->
--                     case (Decode.decodeString (errorDecoder) response.data) of
--                         Ok value ->
--                             case value of
--                                 ArrayError error ->
--                                     case (Array.get 0 error) of
--                                         Just v ->
--                                             v
--
--                                         Nothing ->
--                                             ""
--
--                                 StringError error ->
--                                     error
--
--                         Err error ->
--                             ""
--
--                 _ ->
--                     ""
--     in
--         ( { model | errors = errorText, token = toString error }, Cmd.none )
--
-- ClickLoginUser ->
--     ( model, loginUserCmd model accessUrl )
--
-- LoginSuccess response ->
--     ( { model | name_server = (toString response) }, Cmd.none )


type ErrorType
    = ArrayError (Array String)
    | StringError String


errorDecoder : Decoder ErrorType
errorDecoder =
    oneOf
        [ Decode.map ArrayError ("username" := Decode.array Decode.string)
        , Decode.map StringError ("error" := Decode.string)
        ]



-- API register


registerUrl : String
registerUrl =
    "http://localhost:8000/riw/users/register/"


userEncoder : Model -> Encode.Value
userEncoder model =
    Encode.object
        [ ( "username", Encode.string model.user.username )
        , ( "name", Encode.string model.user.name )
        , ( "password", Encode.string model.user.password )
        , ( "email", Encode.string model.user.email )
        ]


tokenDecoder : Decoder String
tokenDecoder =
    "token" := Decode.string


registerUser : Model -> String -> Task (HttpBuilder.Error String) (HttpBuilder.Response String)
registerUser model registerUrl =
    HttpBuilder.post registerUrl
        |> HttpBuilder.withHeader "Content-Type" "application/json"
        |> HttpBuilder.withJsonBody (userEncoder model)
        |> HttpBuilder.send (HttpBuilder.jsonReader tokenDecoder) HttpBuilder.stringReader



-- registerUser : Model -> String -> Task Http.Error String
-- registerUser model registerUrl =
-- { verb = "POST"
-- , headers = [ ( "Content-type", "application/json" ) ]
-- , url = registerUrl
-- , body = Http.string <| Encode.encode 0 <| userEncoder model
-- }
--     |> Http.send Http.defaultSettings
--     |> Http.fromJson authDecoder


registerUserCmd : Model -> String -> Cmd Msg
registerUserCmd model apiUrl =
    Task.perform RegisterError RegisterSuccess <| registerUser model apiUrl



-- accessUrl : String
-- accessUrl =
--     "http://localhost:8000/riw/users/1/"
-- loginEncoder : Model -> Encode.Value
-- loginEncoder model =
--     Encode.object
--         [ ( "token", Encode.string model.username )
--         , ( "password", Encode.string model.password )
--         ]
-- nameDecoder : Decoder String
-- nameDecoder =
--     let
--         a =
--             Debug.log (toString Decode.string)
--     in
--         "email" := Decode.string
-- loginUser : Model -> String -> Task Http.Error String
-- loginUser model accessUrl =
--     { verb = "GET"
--     , headers = [ ( "Authorization", "Token " ++ model.token ) ]
--     , url = accessUrl
--     , body = Http.empty
--     }
--         |> Http.send Http.defaultSettings
--         |> Http.fromJson nameDecoder
-- loginUser : Model -> String -> Task (HttpBuilder.Error String) (HttpBuilder.Response String)
-- loginUser model accessUrl =
--     HttpBuilder.get accessUrl
--         |> HttpBuilder.withHeader "Authorization" ("Token " ++ model.token)
--         |> HttpBuilder.send (HttpBuilder.jsonReader nameDecoder) HttpBuilder.stringReader
-- loginUserCmd : Model -> String -> Cmd Msg
-- loginUserCmd model apiUrl =
--     Task.perform UserError GetUserSuccess <| loginUser model apiUrl
