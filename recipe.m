classdef recipe
    properties
        ingredientList
        name
    end
    methods
        function r = recipe(ingList, name)
            r.ingredientList = ingList
            r.name = name
        end

    end



end
