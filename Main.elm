module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task exposing (Task)
import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)


--Models
-- type alias Model =
--     { user : User
--     }


type alias Model =
    { username : String
    , name : String
    , password : String
    , email : String
    , error : String
    , nameServer : String
    , emailServer : String
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

        GetUserSuccess dado ->
            ( { model
                | nameServer = dado
              }
            , Cmd.none
            )

        UserError error ->
            ( { model | error = (toString error) }, Cmd.none )



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


userDecoder : Decoder String
userDecoder =
    "name" := Decode.string


registerUser : Model -> String -> Task Http.Error String
registerUser model registerUrl =
    { verb = "POST"
    , headers = [ ( "Content-type", "application/json" ) ]
    , url = registerUrl
    , body = Http.string <| Encode.encode 0 <| userEncoder model
    }
        |> Http.send Http.defaultSettings
        |> Http.fromJson userDecoder


registerUserCmd : Model -> String -> Cmd Msg
registerUserCmd model apiUrl =
    Task.perform UserError GetUserSuccess <| registerUser model apiUrl



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
        ]


main : Program Never
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
