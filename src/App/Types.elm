module App.Types exposing (..)

import Navigation exposing (Location)
import App.Routing exposing (Route)
import Login.Types as Login
import User.Types as User


type alias Model =
    { login : Login.Model
    , route : Route
    , global : Global
    }


type alias Global =
    { user : Maybe User.Model
    , token : String
    }


type Status
    = Login


type Msg
    = UserMsg User.Msg
    | LoginMsg Login.Msg
    | OnLocationChange Location
    | ShowIndex
    | ShowLogin
    | ShowUser
