module Question.State exposing (init, update)

import Http
import Question.Types exposing (..)
import Question.Rest exposing (fetchGetQuestion, fetchGetQuestionPage)
import App.Types as App
import Navigation


initQuestion : Question
initQuestion =
    Question 0 "" "" Nothing "" 0 "" [] []


initQuestionPage : QuestionPage
initQuestionPage =
    QuestionPage 0 1 Nothing Nothing []


init : Model
init =
    Model
        initQuestion
        initQuestionPage
        ""


update : Msg -> Model -> App.Global -> ( Model, Cmd Msg )
update msg model global =
    case msg of
        GetQuestion questionId ->
            model ! [ fetchGetQuestion questionId global.token ]

        GetQuestionPage questionPage ->
            model ! [ fetchGetQuestionPage questionPage global.token ]

        PreviousPage previousPage ->
            model ! [ Navigation.newUrl <| String.concat [ "#questions/", toString previousPage ] ]

        NextPage nextPage ->
            model ! [ Navigation.newUrl <| String.concat [ "#questions/", toString nextPage ] ]

        OnFetchGetQuestion (Ok question) ->
            { model | question = question, error = "" } ! []

        OnFetchGetQuestion (Err error) ->
            let
                errorMsg =
                    case error of
                        Http.NetworkError ->
                            "Erro de conexão com o servidor"

                        Http.BadStatus response ->
                            "Questão inexistente"

                        _ ->
                            toString error
            in
                { model | error = errorMsg } ! []

        OnFetchGetQuestionPage (Ok questionPage) ->
            { model | questionPage = questionPage, error = "" } ! []

        OnFetchGetQuestionPage (Err error) ->
            let
                errorMsg =
                    case error of
                        Http.NetworkError ->
                            "Erro de conexão com o servidor"

                        Http.BadStatus response ->
                            "Página inexistente"

                        _ ->
                            toString error
            in
                { model | error = errorMsg } ! []

        NoOp ->
            model ! []
