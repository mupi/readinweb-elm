module Login.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- My Modules

import Login.Type exposing (..)


view : Model -> Html Msg
view model =
    div [ id "form" ]
        [ h2 [ class "text-center" ] [ text "Login" ]
        , div [ class "form-group row" ]
            [ label [ for "username" ] [ text "Username:" ]
            , input
                [ id "username", type' "text", class "form-control", onInput SetUsername, placeholder "Username", value model.user.username ]
                [ text model.user.username ]
            ]
        , div [ class "form-group row" ]
            [ label [ for "password" ] [ text "Senha:" ]
            , input
                [ id "password", type' "password", class "form-control", onInput SetPassword, placeholder "Senha", value model.user.password ]
                [ text model.user.password ]
            ]
        , div [ class "text-center" ]
            [ p [ class "text-danger" ] [ text model.error ] ]
        , div [ class "text-center form-group row" ]
            [ button [ class "btn btn-primary", onClick ClickLoginUser ] [ text "Login" ]
              -- , button [ class "btn btn-link", onClick ClickLoginUser ] [ text "Ver" ]
            ]
        ]
