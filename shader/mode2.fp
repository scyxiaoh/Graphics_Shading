// mode 2 - ambient and Lambertian lighting

varying vec3 N;  // surface normal in camera 
varying vec3 v;  // surface fragment location in camera 
 
void main(void) {

	vec3 L = normalize(gl_LightSource[0].position.xyz - v);
	
	vec4 Iamb = gl_FrontLightProduct[0].ambient;
	
	vec4 Idiff = gl_FrontLightProduct[0].diffuse * max(dot(N,L), 0.0);
	Idiff = clamp(Idiff, 0.0, 1.0);
	
    gl_FragColor = Iamb + Idiff;
}