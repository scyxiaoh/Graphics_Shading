// mode 4 - ambient and Lambertian and Specular with shadow map

uniform sampler2D shadowMap; 
uniform float sigma;

varying vec3 N;  // surface normal in camera 
varying vec3 v;  // surface fragment location in camera 
varying vec4 vL; // surface fragment location in light view NDC
 
void main(void) {

	// TODO: Objective 6: ambient, Labertian, and Specular with shadow map.
	// Note that the shadow map lookup should only modulate the Lambertian and Specular component.
   	vec3 L = normalize(gl_LightSource[0].position.xyz - v);   
   	vec3 E = normalize(-v);
   	vec3 R = normalize(-reflect(L,N));  
 
  	vec4 Iamb = gl_FrontLightProduct[0].ambient;    
  	
   	vec4 Idiff = gl_FrontLightProduct[0].diffuse * max(dot(N,L), 0.0);
   	Idiff = clamp(Idiff, 0.0, 1.0);     
   
  	vec4 Ispec = gl_FrontLightProduct[0].specular * pow(max(dot(R,E),0.0), 0.5 * gl_FrontMaterial.shininess);
   	Ispec = clamp(Ispec, 0.0, 1.0); 
   	
   	vec4 coord =  (vL / vL.w) * 0.5 + 0.5;

   	float distanceFromLight = texture2D(shadowMap,coord.xy).z;
   	float shadow = 1.0;
   	if (vL.w > 0.0) shadow = distanceFromLight + sigma < coord.z ? 0.0 : 1.0;
   	
   	gl_FragColor = Iamb + shadow * (Idiff + Ispec);
}