// Created by anatole duprat - XT95/2016
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

/*
Never dream to have slider,text display and color picker for you shader ? 
Here we are! 
Easy peasy to integrate :
- copy/paste buffer A to your shader
- modify the mainImage() to make your own IU
- just mix your final render with the buffer A
- enjoy :)

Any suggestions are very welcome!

Thx to :
Smooth HSV - iq : https://www.shadertoy.com/view/MsS3Wc
Rounded box - iq : https://www.shadertoy.com/view/4llXD7
96-Bit 8x12 font - Flyguy : https://www.shadertoy.com/view/Mt2GWD
*/

//Only what you need in your shaders to get the IU inputs
float uiSlider(int id){return texture(iChannel0, vec2(float(id)+.5,0.5)/iResolution.xy).r;}
vec3 uiColor(int id){return texture(iChannel0, vec2(float(id)+.5,1.5)/iResolution.xy).rgb;}

vec3 palette( float t ) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263,0.416,0.557);

    return a + b*cos( 6.28318*(c*t+d) );
}

//https://www.shadertoy.com/view/mtyGWy
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    float r1 = uiSlider(1) * 10.;
    float r2 = uiSlider(2) * 10.;
    float r3 = uiSlider(3) * 10.;
    float r4 = uiSlider(4);
    float r5 = uiSlider(5) * 10.;
    float r6 = uiSlider(6);
    
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    
    for (float i = 0.0; i < r1; i++) {
        uv = fract(uv * r2) - r4;

        float d = length(uv) * exp(-length(uv0));

        vec3 col = palette(length(uv0) + i*r6  + iTime*r6 );

        d = sin(d*r3 + iTime)/r3;
        d = abs(d);

        d = pow(0.01 / d, r5);

        finalColor += col * d;
    }
        
    //fragColor = vec4(finalColor, 1.0);
    
    //UI
    vec4 ui = texture(iChannel0, fragCoord/iResolution.xy);
    //fragColor = mix(vec4(finalColor, 1.0), ui, ui.a);
    
    finalColor = mix(finalColor,ui.rgb, ui.a*.8);
        
	fragColor = vec4( finalColor, 1. );
}