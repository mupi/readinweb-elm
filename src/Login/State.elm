module Login.State exposing (init, update)

import Http
import Login.Types exposing (..)
import Login.Rest exposing (..)
import User.State as User


init : Model
init =
    Model User.init "" "" "" ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetUsername newUsername ->
            { model | username = newUsername } ! []

        SetPassword newPassword ->
            { model | password = newPassword } ! []

        Login ->
            ( model, fetchLogin model )

        OnFetchLogin (Ok login) ->
            { model | user = login.user, token = login.token, error = "" } ! []

        OnFetchLogin (Err error) ->
            let
                errorMsg =
                    case error of
                        Http.NetworkError ->
                            "Erro de conexão com o servidor"

                        Http.BadStatus response ->
                            "Usuário e/ou senha inválido(s)"

                        _ ->
                            "Erro indefinido"
            in
                { model | error = errorMsg } ! []

        NoOp ->
            model ! []
