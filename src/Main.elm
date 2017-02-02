module Main exposing (..)

import Html exposing (program)
import View exposing (view)
import State exposing (init, update, subscriptions)
import Type exposing (Model, Msg)


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
