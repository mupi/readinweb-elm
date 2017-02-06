module Main exposing (..)

import View exposing (view)
import State exposing (init, update, subscriptions)
import Types exposing (Model, Msg(..))
import Navigation exposing (program)


main : Program Never Model Msg
main =
    program OnLocationChange
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
