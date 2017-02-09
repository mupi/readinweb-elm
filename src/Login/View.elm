module Login.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, type_, for, value, class)
import Html.Events exposing (..)
import Login.Types exposing (..)
import Material.Textfield as Textfield
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Grid exposing (grid, cell, size, offset, Device(..))


-- import State exposing (..)


view : Model -> Html Msg
view model =
    grid []
        [ cell [ size All 6 ]
            [ Html.h1 [] [ text "Sign-up" ]
            ]
        , cell [ size All 6 ]
            [ Html.h1 [] [ text "Login Form" ]
            , div []
                [ Textfield.render Mdl
                    [ 0 ]
                    model.mdl
                    [ Textfield.label "Usuário"
                    , Textfield.text_
                    , Textfield.floatingLabel
                    , Textfield.value model.username
                    , Options.onInput SetUsername
                    ]
                    []
                ]
            , div []
                [ Textfield.render Mdl
                    [ 1 ]
                    model.mdl
                    [ Textfield.label "Senha"
                    , Textfield.floatingLabel
                    , Textfield.password
                    , Textfield.value model.password
                    , Options.onInput SetPassword
                    ]
                    []
                ]
            , div [ class "text-alert" ]
                [ text model.error ]
            , div []
                [ Button.render Mdl
                    [ 0 ]
                    model.mdl
                    [ Button.raised
                    , Button.colored
                    , Options.onClick Login
                    ]
                    [ text "Sign in" ]
                ]
            , text (toString model)
            ]
        ]
