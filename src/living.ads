package Living is 

    type Living_Type is abstract tagged record
        Health : Natural := 10;
        Age : Natural := Natural'First;
    end record;

    function Health (Living : Living_Type'Class) return Natural;

    procedure Increment_Age (Living : in out Living_Type'Class);

    procedure Gain_Health (Living : in out Living_Type'Class; Count : Natural);
    procedure Lose_Health (Living : in out Living_Type'Class; Count : Natural);

    function Is_Alive (Living : Living_Type'Class) return Boolean;

    function Can_Reproduce (Living : Living_Type) return Boolean is abstract;

end Living;