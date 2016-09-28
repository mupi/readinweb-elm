module View exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Type exposing (..)


-- My Modules

import Register.View as Register exposing (..)
import Login.View as Login exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ navbar model
        , div [ class "container" ]
            [ div [ class "jumbotron text-left" ]
                [ case model.status of
                    Register ->
                        Html.App.map RegisterMsg (Register.view model.register)

                    Login ->
                        Html.App.map LoginMsg (Login.view model.login)

                    _ ->
                        div [] []
                ]
            , p [] [ text (toString model) ]
            ]
        ]


navbar : Model -> Html Msg
navbar model =
    div [ class "navbar navbar-inverse" ]
        [ div [ class "container" ]
            [ div [ class "navbar_header" ]
                [ a [ class "navbar-brand", href "#" ] [ text "Readinweb" ]
                ]
            , if model.user.token == "" then
                ul [ class "nav navbar-nav navbar-right" ]
                    [ li []
                        [ a [ onClick (ChangeStatus Register), href "#" ] [ span [ class "glyphicon glyphicon-user" ] [], text " Registrar-se" ]
                        ]
                    , li []
                        [ a [ onClick (ChangeStatus Login), href "#" ] [ span [ class "glyphicon glyphicon-log-in" ] [], text " Login" ]
                        ]
                    ]
              else
                ul [ class "nav navbar-nav navbar-right" ]
                    [ li [ class "navbar-text" ] [ text ("Bem vindo, " ++ model.user.name) ] ]
            ]
        ]
