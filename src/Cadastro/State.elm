module Cadastro.State exposing (init, update)

import Cadastro.Type exposing (..)
import Task exposing (Task)
import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Cadastro.Type exposing (..)


init : Model
init =
    Model "" "" "" "" "" "" ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetUsername username ->
            ( { model | username = username }, Cmd.none )

        SetName name ->
            ( { model | name = name }, Cmd.none )

        SetEmail email ->
            ( { model | email = email }, Cmd.none )

        SetPassword password ->
            ( { model | password = password }, Cmd.none )

        ClickRegisterUser ->
            ( model, registerUserCmd model registerUrl )

        GetUserSuccess token ->
            ( { model
                | token = token
              }
            , Cmd.none
            )

        UserError error ->
            ( { model | error = (toString error) }, Cmd.none )

        ClickLoginUser ->
            ( model, loginUserCmd model accessUrl )

        LoginSuccess name ->
            ( { model | name_server = name }, Cmd.none )



-- API register


registerUrl : String
registerUrl =
    "http://localhost:8000/riw/users/register/"


userEncoder : Model -> Encode.Value
userEncoder model =
    Encode.object
        [ ( "username", Encode.string model.username )
        , ( "name", Encode.string model.name )
        , ( "password", Encode.string model.password )
        , ( "email", Encode.string model.email )
        ]


authDecoder : Decoder String
authDecoder =
    "token" := Decode.string


registerUser : Model -> String -> Task Http.Error String
registerUser model registerUrl =
    { verb = "POST"
    , headers = [ ( "Content-type", "application/json" ) ]
    , url = registerUrl
    , body = Http.string <| Encode.encode 0 <| userEncoder model
    }
        |> Http.send Http.defaultSettings
        |> Http.fromJson authDecoder


registerUserCmd : Model -> String -> Cmd Msg
registerUserCmd model apiUrl =
    Task.perform UserError LoginSuccess <| registerUser model apiUrl


accessUrl : String
accessUrl =
    "http://localhost:8000/riw/users/1/"



-- loginEncoder : Model -> Encode.Value
-- loginEncoder model =
--     Encode.object
--         [ ( "token", Encode.string model.username )
--         , ( "password", Encode.string model.password )
--         ]


nameDecoder : Decoder String
nameDecoder =
    let
        a =
            Debug.log (toString Decode.string)
    in
        "email" := Decode.string


loginUser : Model -> String -> Task Http.Error String
loginUser model accessUrl =
    { verb = "GET"
    , headers = [ ( "Authorization", "Token " ++ model.token ) ]
    , url = accessUrl
    , body = Http.empty
    }
        |> Http.send Http.defaultSettings
        |> Http.fromJson nameDecoder


loginUserCmd : Model -> String -> Cmd Msg
loginUserCmd model apiUrl =
    Task.perform UserError GetUserSuccess <| loginUser model apiUrl
