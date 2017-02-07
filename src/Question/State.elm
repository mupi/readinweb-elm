module Question.State exposing (init, update)

import Http
import Question.Types exposing (..)
import Question.Rest exposing (fetchGet)
import App.Types as App


init : Model
init =
    Model
        (Question
            0
            ""
            ""
            ""
            ""
            0
            ""
            []
            []
        )
        ""


update : Msg -> Model -> App.Global -> ( Model, Cmd Msg )
update msg model global =
    case msg of
        GetUser questionId ->
            model ! [ fetchGet questionId global.token ]

        OnFetchGet (Ok question) ->
            { model | question = question, error = "" } ! []

        OnFetchGet (Err error) ->
            let
                errorMsg =
                    case error of
                        Http.NetworkError ->
                            "Erro de conexão com o servidor"

                        Http.BadStatus response ->
                            "Usuário e/ou senha inválido(s)"

                        _ ->
                            toString error
            in
                { model | error = errorMsg } ! []

        NoOp ->
            model ! []
