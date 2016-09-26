module Login.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- My Modules

import Login.Type exposing (..)


view : Model -> Html Msg
view model =
    div [ id "form" ]
        [ h1 [ class "text-center" ]
            [ text "Readinweb" ]
        , h2 [ class "text-center" ] [ text "Cadastrar-se" ]
        , div [ class "form-group row" ]
            [ label [ for "username" ] [ text "Username:" ]
            , input
                [ id "username", type' "text", class "form-control", onInput SetUsername, placeholder "Username" ]
                []
            ]
        , div [ class "form-group row" ]
            [ label [ for "password" ] [ text "password:" ]
            , input
                [ id "password", type' "password", class "form-control", onInput SetPassword, placeholder "Password" ]
                []
            ]
        , div [ class "text-center" ]
            [ p [ class "text-danger" ] [ text model.error ] ]
        , div [ class "text-center form-group row" ]
            [ button [ class "btn btn-primary", onClick ClickLoginUser ] [ text "Login" ]
              -- , button [ class "btn btn-link", onClick ClickLoginUser ] [ text "Ver" ]
            ]
        ]
