module User.Type exposing (..)


type alias Model =
    { username : String
    , name : String
    , email : String
    , password : String
    , token : String
    }


type Msg
    = SetUsername String
    | SetEmail String
    | SetName String
    | SetPassword String
