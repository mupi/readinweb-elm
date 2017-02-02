module Login.Rest exposing (..)

import Http exposing (..)
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode exposing (Value, encode, object, string)
import Login.Type exposing (..)
import User.Rest as User


url : String
url =
    "http://localhost:8000/rest/auth/login/"


loginJson : Model -> Value
loginJson model =
    object
        [ ( "username", string model.username )
        , ( "password", string model.password )
        ]


bodyBuild : Model -> Body
bodyBuild model =
    stringBody "application/json" (encode 0 (loginJson model))


postLogin : Model -> Http.Request LoginModel
postLogin model =
    Http.post url (bodyBuild model) loginDecoder


fetchLogin : Model -> Cmd Msg
fetchLogin model =
    Http.send OnFetchLogin (postLogin model)


loginDecoder : Decode.Decoder LoginModel
loginDecoder =
    Decode.map2 LoginModel
        (field "user" User.userDecoder)
        (field "token" Decode.string)
