package body Fish is

    function Create
        (Name    : String;
         Gender  : Gender_Type;
         Species : Species_Type;
         Health  : Natural := 10)
        return Fish_Type
    is
        Fish : constant Fish_Type := (
            Name    => To_Unbounded_String (Name), 
            Gender  => Gender,
            Species => Species,
            Health  => Health,
            others  => <>);
    begin
        return Fish;
    end Create;

    function Species (Fish : Fish_Type) return Species_Type is
    begin
        return Fish.Species;
    end Species;

    function Gender (Fish : Fish_Type) return Gender_Type is
    begin
        case Sexuality (Fish) is
            when Age_Hermaphrodite =>
                if Fish.Age <= 10 then
                    return Male;
                else
                    return Female;
                end if;
            when others => 
                return Fish.Gender;
        end case;
    end Gender;

    function Diet (Species : Species_Type) return Diet_Type is
    begin
        if Species in Herbivorous_Species then
            return Herbivorous;
        else
            return Carnivorous;
        end if;
    end Diet;

    function Diet (Fish : Fish_Type) return Diet_Type is
    begin
        return Diet (Species (Fish));
    end Diet;

    function Sexuality (Species : Species_Type) return Sexuality_Type is
    begin 
        if Species in Monosexual_Species then
            return Monosexual;
        elsif Species in Age_Hermaphrodite_Species then
            return Age_Hermaphrodite;
        else
            return Opportunistic_Hermaphrodite;
        end if;
    end Sexuality;

    function Sexuality (Fish : Fish_Type) return Sexuality_Type is
    begin 
        return Sexuality (Species (Fish));
    end Sexuality;

    function Is_Hungry (Fish : Fish_Type) return Boolean is
    begin
        return Fish.Health <= 5;
    end Is_Hungry;

    Overriding
    function Can_Reproduce (Fish : Fish_Type) return Boolean is
    begin
        return not Fish.Is_Hungry;
    end Can_Reproduce;

    function Will_Bang (Fish, Partner : Fish_Type) return boolean is
    begin
        if (Species (Fish) /= Species (Partner)) then
            return False;
        end if;

        case Sexuality (Fish) is
            when Monosexual | Age_Hermaphrodite =>
                return Gender (Fish) /= Gender (Partner);
            when Opportunistic_Hermaphrodite =>
                return True;
        end case;
    end Will_Bang;

    procedure Eat (Fish : in out Fish_Type; Living : in out Living_Type'Class) is
    begin
        case Fish.Diet is
            when Carnivorous => -- Means that living is a fish
                Living.Lose_Health (4);
                Fish.Gain_Health (5);
            when Herbivorous => -- Means that living is a seaweed
                Living.Lose_Health (2);
                Fish.Gain_Health (3);
        end case;
    end Eat;

    function Image (Gender : Gender_Type) return String is
    begin
        return (case Gender is
            when Female => "Female",
            when Male   => "Male");
    end Image;

    function Image (Diet : Diet_Type) return String is
    begin
        return (case Diet is
            when Herbivorous => "Herbivorous",
            when Carnivorous => "Carnivorous");
    end Image;

    function Image (Species : Species_Type) return String is
    begin
        return (case Species is
            when Grouper   => "Grouper",
            when Tuna      => "Tuna",
            when Clownfish => "Clownfish",
            when Sole      => "Sole",
            when Seabass   => "Seabass",
            when Carp      => "Carp");
    end Image;

    function Image (Fish : Fish_Type) return String is
        G : constant String := Image (Gender (Fish));
        S : constant String := Image (Species (Fish));
        D : constant String := Image (Diet (Fish.Species));
    begin
        return To_String (Fish.Name)
            & ", " & G 
            & ", " & S
            & " (" & D & ")"
            & ", Age: " & Fish.Age'Img
            & ", Health: " & Fish.Health'Img;
    end Image;

end Fish;