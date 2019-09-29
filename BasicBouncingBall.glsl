#define radius .05 
#define BGB false

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (fragCoord-.5*iResolution.xy)/iResolution.xy; //Center on screen (-.5 to .5)
	uv.x = uv.x * (iResolution.x/iResolution.y); //Adjust x cord for aspect ratio

	
    vec3 ro = vec3(0);
    vec3 rd = normalize(vec3(uv.x, uv.y, 1));
    
    vec3 s = vec3(0.05, 0.05, abs(sin(iTime)/2.));
    
    float t = dot(s-ro, rd);
    
    vec3 p = ro + rd*t;
    
    float y = length(p-s);
    
    float x = sqrt(radius*radius - y*y);
    
    float t1 = x + t;
    
    float t2 = x - t;
    
    float dist = length(ro +rd*t1);
    
    float blink_bg = BGB ? abs(sin(iTime)) : 1.;
    
    vec3 ballcolor = bool(int(iTime)%10) ? vec3(1, .2, 0) 
        : vec3(float((int(fragCoord.x)*2)^(int(fragCoord.y)*2))/((iResolution.x*iResolution.y)/300.),.2,0);
    
    vec3 col = dist > 0. ? mix(vec3(x*20. - dist), ballcolor, .4) : //"Raytraced" ball
    	vec3(0,0,float(int(fragCoord.x)^int(fragCoord.y))/((iResolution.x*iResolution.y)/300./blink_bg) ); //Generate background
    
    // Output to screen
    fragColor = vec4(col,1.0);
}