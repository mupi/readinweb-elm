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
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Layout as Layout


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header = header model
        , drawer = []
        , tabs = ( [], [] )
        , main = [ page model ]
        }


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


header : Model -> List (Html Msg)
header model =
    let
        user =
            model.global.user
    in
        if user == Nothing then
            [ Layout.row
                [ Options.nop
                , css "transition" "height 333ms ease-in-out 0s"
                ]
                [ Layout.link
                    [ Layout.href "/" ]
                    [ Layout.title [] [ text "MupiLab" ] ]
                , Layout.spacer
                , Layout.navigation []
                    [ Button.render Mdl
                        [ 0 ]
                        model.mdl
                        [ Button.flat
                        , Button.plain
                        , Options.onClick ShowIndex
                        ]
                        [ text "Home" ]
                    , Button.render Mdl
                        [ 1 ]
                        model.mdl
                        [ Button.flat
                        , Button.plain
                        , Options.onClick ShowLogin
                        ]
                        [ text "Login" ]
                    ]
                ]
            ]
        else
            [ Layout.row
                [ Options.nop ]
                [ Layout.link
                    [ Layout.href "/" ]
                    [ Layout.title [] [ text "MupiLab" ] ]
                , Layout.spacer
                , Layout.navigation []
                    [ Button.render Mdl
                        [ 0 ]
                        model.mdl
                        [ Button.flat
                        , Button.plain
                        , Options.onClick ShowIndex
                        ]
                        [ text "Home" ]
                    , Button.render Mdl
                        [ 1 ]
                        model.mdl
                        [ Button.flat
                        , Button.plain
                        , Options.onClick ShowUser
                        ]
                        [ text "My account" ]
                    , Button.render Mdl
                        [ 2 ]
                        model.mdl
                        [ Button.flat
                        , Button.plain
                        , Options.onClick (LoginMsg Login.Logout)
                        ]
                        [ text "Logout" ]
                    ]
                ]
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
            [ text "404 - Page Not found!"
            ]
