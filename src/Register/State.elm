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
                ( newUser, cmd ) =
                    User.update (User.SetToken sucesso.data) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        RegisterError error ->
            ( { model | error = toString error }, Cmd.none )


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


registerUserCmd : Model -> String -> Cmd Msg
registerUserCmd model apiUrl =
    Task.perform RegisterError RegisterSuccess <| registerUser model apiUrl
