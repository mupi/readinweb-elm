module Login.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, type_, for, value, class)
import Html.Events exposing (..)
import Login.Types exposing (..)


-- import State exposing (..)


view : Model -> Html Msg
view model =
    div [ id "signup-form" ]
        [ Html.h1 [] [ text "Login Form" ]
        , label [ for "username-field" ] [ text "Username: " ]
        , input [ id "username", type_ "text", onInput SetUsername ] []
        , label [ for "password" ] [ text "Password: " ]
        , input [ id "password", type_ "password", onInput SetPassword ] []
        , button [ onClick Login ] [ text "Sign Up" ]
        , text (toString model)
        ]
