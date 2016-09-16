module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task exposing (Task)
import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)


type alias Model =
    { username : String
    , name : String
    , password : String
    , email : String
    , error : String
    , token : String
    , name_server : String
    }


initModel : Model
initModel =
    Model "" "" "" "" "" "" ""


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



--Update


type Msg
    = SetUsername String
    | SetEmail String
    | SetName String
    | SetPassword String
    | ClickRegisterUser
    | GetUserSuccess String
    | UserError Http.Error
    | ClickLoginUser
    | LoginSuccess String


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



--View


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Readinweb" ]
        , input
            [ type' "text", onInput SetName, placeholder "Nome" ]
            []
        , input
            [ type' "text", onInput SetUsername, placeholder "Username" ]
            []
        , input
            [ type' "text", onInput SetEmail, placeholder "Email" ]
            []
        , input
            [ type' "password", onInput SetPassword, placeholder "Password" ]
            []
        , button [ onClick ClickRegisterUser ] [ text "Enviar" ]
        , button [ onClick ClickLoginUser ] [ text "ver" ]
        , p [] [ text (toString model) ]
        ]


main : Program Never
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
