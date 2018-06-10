// mode3 - ambient and Lambertian and specular lighting

varying vec3 N;  // surface normal in camera 
varying vec3 v;  // surface fragment location in camera 
 
void main(void) {

   	vec3 L = normalize(gl_LightSource[0].position.xyz - v);   
   	vec3 E = normalize(-v);
   	vec3 R = normalize(-reflect(L,N));  
 
  	vec4 Iamb = gl_FrontLightProduct[0].ambient;    
  	
   	vec4 Idiff = gl_FrontLightProduct[0].diffuse * max(dot(N,L), 0.0);
   	Idiff = clamp(Idiff, 0.0, 1.0);     
   
  	vec4 Ispec = gl_FrontLightProduct[0].specular * pow(max(dot(R,E),0.0), 0.5 * gl_FrontMaterial.shininess);
   	Ispec = clamp(Ispec, 0.0, 1.0);  
   	
   	gl_FragColor = Iamb + Idiff + Ispec; 

}