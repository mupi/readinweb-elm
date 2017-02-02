module Type exposing (..)

-- My modules

import User.Type as User
import Login.Type as Login


type alias Model =
    { user : User.Model
    , login : Login.Model
    }


type Status
    = Login


type Msg
    = UserMsg User.Msg
    | LoginMsg Login.Msg
