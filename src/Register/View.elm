module Register.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- My Modules

import Register.Type exposing (..)


view : Model -> Html Msg
view model =
    div [ id "form" ]
        [ h2 [ class "text-center" ] [ text "Registrar-se" ]
        , div [ class "form-group row" ]
            [ label [ for "name" ] [ text "Nome:" ]
            , input
                [ id "name", type' "text", class "form-control", onInput SetName, placeholder "Nome", value model.user.name ]
                [ text model.user.name ]
            ]
        , div [ class "form-group row" ]
            [ label [ for "username" ] [ text "Username:" ]
            , input
                [ id "username", type' "text", class "form-control", onInput SetUsername, placeholder "Username", value model.user.username ]
                [ text model.user.username ]
            ]
        , div [ class "form-group row" ]
            [ label [ for "email" ] [ text "Email:" ]
            , input
                [ id "email", type' "email", class "form-control", onInput SetEmail, placeholder "Email", value model.user.email ]
                [ text model.user.email ]
            ]
        , div [ class "form-group row" ]
            [ label [ for "password" ] [ text "password:" ]
            , input
                [ id "password", type' "password", class "form-control", onInput SetPassword, placeholder "Password", value model.user.password ]
                [ text model.user.password ]
            ]
        , div [ class "text-center form-group row" ]
            [ button [ class "btn btn-primary", onClick ClickRegisterUser ] [ text "Registrar" ]
              -- , button [ class "btn btn-link", onClick ClickLoginUser ] [ text "Ver" ]
            ]
        ]
