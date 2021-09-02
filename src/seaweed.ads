with Living; use Living;


package Seaweed is 

    type Seaweed_Type is new Living_Type with private;

    function Create (Health : Natural := 10) return Seaweed_Type;

    procedure Grow (Seaweed : in out Seaweed_Type);

    Overriding
    function Can_Reproduce (Seaweed : Seaweed_Type) return Boolean;

    function Image (Seaweed : Seaweed_Type) return String;

private

    type Seaweed_Type is new Living_Type with null record;

end Seaweed;