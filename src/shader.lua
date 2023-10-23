--Shader to split background and add colors
Shader = class("Shader")

function Shader:initialize()
    self.background = love.graphics.newShader[[
    uniform float windowHeight;

	vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ) {
        if(screen_coords.y > windowHeight/2) {
            color  =  vec4(0.08,0.5,0.1,1.);
            return color;
        }
        else
        {
            color  =  vec4(.03,.7,.7,1.);
            return color;
        }
	}
    ]]
end