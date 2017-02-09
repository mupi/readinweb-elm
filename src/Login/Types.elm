module Login.Types exposing (..)

import Http
import User.Types as User


type alias Model =
    { user : Maybe User.Model
    , username : String
    , password : String
    , token : Maybe String
    , error : String
    }


type alias LoginModel =
    { user : User.Model
    , token : String
    }


type Msg
    = SetUsername String
    | SetPassword String
    | Login
    | Logout
    | OnFetchLogin (Result Http.Error LoginModel)
    | NoOp
