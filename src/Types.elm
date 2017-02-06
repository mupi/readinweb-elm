module Types exposing (..)

import Navigation exposing (Location)
import Routing
import User.Types as User
import Login.Types as Login


type alias Model =
    { user : User.Model
    , login : Login.Model
    , route : Routing.Route
    }


type Status
    = Login


type Msg
    = UserMsg User.Msg
    | LoginMsg Login.Msg
    | OnLocationChange Location
