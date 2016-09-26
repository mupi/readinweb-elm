module Login.State exposing (init, update)

import Task exposing (Task)
import HttpBuilder
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Array exposing (..)


-- My Modules

import Login.Type exposing (..)
import User.Type as User
import User.State as User
import Login.Type as Login


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

        SetPassword password ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetPassword password) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        ClickLoginUser ->
            ( { model | error = "" }, loginUserCmd model loginUrl )

        GetTokenSuccess sucesso ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetToken sucesso.data) model.user
            in
                ( { model | user = newUser }, getUserCmd newUser.token getUserUrl )

        GetTokenError error ->
            case error of
                HttpBuilder.BadResponse response ->
                    ( { model | error = "Usuario ou senha incorretos" }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        LoginSuccess sucesso ->
            let
                newUser : User.Model
                newUser =
                    { userId = sucesso.data.userId
                    , username = sucesso.data.username
                    , name = sucesso.data.name
                    , email = sucesso.data.email
                    , password = model.user.password
                    , token = model.user.token
                    }
            in
                ( { model | user = newUser }, Cmd.none )

        LoginError error ->
            case error of
                HttpBuilder.BadResponse response ->
                    ( { model | error = toString error }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


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


loginUrl : String
loginUrl =
    "http://localhost:8000/riw/api-token-auth/"


loginEncoder : Model -> Encode.Value
loginEncoder model =
    Encode.object
        [ ( "username", Encode.string model.user.username )
        , ( "password", Encode.string model.user.password )
        ]


tokenDecoder : Decoder String
tokenDecoder =
    "token" := Decode.string


loginUser : Model -> String -> Task (HttpBuilder.Error String) (HttpBuilder.Response String)
loginUser model loginUrl =
    HttpBuilder.post loginUrl
        |> HttpBuilder.withHeader "Content-Type" "application/json"
        |> HttpBuilder.withJsonBody (loginEncoder model)
        |> HttpBuilder.send (HttpBuilder.jsonReader tokenDecoder) HttpBuilder.stringReader


loginUserCmd : Model -> String -> Cmd Msg
loginUserCmd model apiUrl =
    Task.perform GetTokenError GetTokenSuccess <| loginUser model apiUrl



-- API register


getUserUrl : String
getUserUrl =
    "http://localhost:8000/riw/users/login/"


userDecoder : Decoder Login.UserAux
userDecoder =
    Decode.object4 UserAux
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("email" := Decode.string)
        ("username" := Decode.string)


getUser : String -> String -> Task (HttpBuilder.Error String) (HttpBuilder.Response Login.UserAux)
getUser token getUserUrl =
    HttpBuilder.get getUserUrl
        |> HttpBuilder.withHeader "Authorization" ("Token " ++ token)
        |> HttpBuilder.send (HttpBuilder.jsonReader userDecoder) HttpBuilder.stringReader


getUserCmd : String -> String -> Cmd Msg
getUserCmd token apiUrl =
    Task.perform LoginError LoginSuccess <| getUser token apiUrl
