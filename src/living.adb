package body Living is

    function Health (Living : Living_Type'Class) return Natural is
    begin 
        return Living.Health;
    end Health;

    procedure Increment_Age (Living : in out Living_Type'Class) is
    begin
        Living.Age := @ + 1;
    end Increment_Age;

    procedure Gain_Health (Living : in out Living_Type'Class; Count : Natural) is
    begin
        Living.Health := @ + Count;
    end Gain_Health;

    procedure Lose_Health (Living : in out Living_Type'Class; Count : Natural) is
    begin
        if (Integer (Living.Health) - Integer (Count)) < 0 then
            Living.Health := 0;
        else
            Living.Health := @ - Count;
        end if;
    end Lose_Health;

    function Is_Alive (Living : Living_Type'Class) return Boolean is
    begin
        return Living.Health /= Natural'First and Living.Age < 20;
    end Is_Alive;

end Living;