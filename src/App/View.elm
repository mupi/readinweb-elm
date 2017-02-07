module App.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Types exposing (..)
import Login.View as Login
import Login.Types as Login
import Question.View as Question
import Question.Types as Question
import User.View as User
import App.Routing exposing (Route(..))
import Material


view : Model -> Html Msg
view model =
    div []
        [ header model
        , page model
        ]


page : Model -> Html Msg
page model =
    case model.route of
        Index ->
            index

        UsersRoute ->
            case model.global.user of
                Nothing ->
                    div [] []

                Just user ->
                    Html.map UserMsg (User.view user)

        LoginRoute ->
            Html.map LoginMsg (Login.view model.login)

        QuestionRoute questionId ->
            Html.map QuestionMsg (Question.view model.question)

        QuestionPageRoute questionId ->
            Html.map QuestionMsg (Question.viewQuestionPage model.question)

        NotFoundRote ->
            notFoundView


header : Model -> Html Msg
header model =
    let
        user =
            model.global.user
    in
        if user == Nothing then
            div []
                [ button [ onClick ShowIndex ] [ text "Index" ]
                , button [ onClick ShowLogin ] [ text "Login" ]
                , text (toString model)
                ]
        else
            div []
                [ button [ onClick ShowIndex ] [ text "Index" ]
                , button [ onClick ShowUser ] [ text "User" ]
                , button [ onClick (LoginMsg Login.Logout) ] [ text "Logout" ]
                , text (toString model)
                ]


index : Html Msg
index =
    div [] [ text "Hello world" ]


notFoundView : Html Msg
notFoundView =
    let
        a =
            Debug.log "location" 1
    in
        div []
            [ text "Not found!!"
            ]
