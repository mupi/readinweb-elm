module Cadastro.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Cadastro.Type exposing (..)


registerForm : Model -> Html Msg
registerForm model =
    div [ id "form" ]
        [ h1 [ class "text-center" ]
            [ text "Readinweb" ]
        , h2 [ class "text-center" ] [ text "Cadastrar-se" ]
        , div [ class "form-group row" ]
            [ label [ for "name" ] [ text "Nome:" ]
            , input
                [ id "name", type' "text", class "form-control", onInput SetName, placeholder "Nome" ]
                []
            ]
        , div [ class "form-group row" ]
            [ label [ for "username" ] [ text "Username:" ]
            , input
                [ id "username", type' "text", class "form-control", onInput SetUsername, placeholder "Username" ]
                []
            ]
        , div [ class "form-group row" ]
            [ label [ for "email" ] [ text "Email:" ]
            , input
                [ id "email", type' "email", class "form-control", onInput SetEmail, placeholder "Email" ]
                []
            ]
        , div [ class "form-group row" ]
            [ label [ for "password" ] [ text "password:" ]
            , input
                [ id "password", type' "password", class "form-control", onInput SetPassword, placeholder "Password" ]
                []
            ]
        , div [ class "text-center form-group row" ]
            [ button [ class "btn btn-primary", onClick ClickRegisterUser ] [ text "Cadastrar" ]
            , button [ class "btn btn-link", onClick ClickLoginUser ] [ text "Ver" ]
            ]
        , p [] [ text (toString model) ]
        ]
