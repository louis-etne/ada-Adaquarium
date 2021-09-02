package body Seaweed is

    function Create (Health : Natural := 10) return Seaweed_Type is
        Seaweed : constant Seaweed_Type := (Health => Health,  others => <>);
    begin
        return Seaweed;
    end Create;

    procedure Grow (Seaweed : in out Seaweed_Type) is
    begin
        Seaweed.Gain_Health (1);
        Seaweed.Increment_Age;
    end Grow;

    Overriding
    function Can_Reproduce (Seaweed : Seaweed_Type) return Boolean is
    begin
        return Seaweed.Health >= 10;
    end Can_Reproduce;

    function Image (Seaweed: Seaweed_Type) return String is
    begin
        return "Health:" & Seaweed.Health'Img & ", Age:" & Seaweed.Age'Img;
    end Image;

end Seaweed;