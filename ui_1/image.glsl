/* This animation is the material of my first youtube tutorial about creative 
   coding, which is a video in which I try to introduce programmers to GLSL 
   and to the wonderful world of shaders, while also trying to share my recent 
   passion for this community.
                                       Video URL: https://youtu.be/f4s1h2YETNY
*/

//https://iquilezles.org/articles/palettes/
float readFloat(float address) { return texture(iChannel0, (floor(vec2(address, 1))+0.5) / iChannelResolution[0].xy).r; }

vec3 palette( float t ) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263,0.416,0.557);

    return a + b*cos( 6.28318*(c*t+d) );
}

//https://www.shadertoy.com/view/mtyGWy
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    float r1 = readFloat(1.) * 10.;
    float r2 = readFloat(2.) * 10.;
    float r3 = readFloat(3.) * 10.;
    float r4 = readFloat(4.);
    float r5 = readFloat(5.) * 10.;
    float r6 = readFloat(6.);
    
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
    fragColor = mix(vec4(finalColor, 1.0), ui, ui.a);
}