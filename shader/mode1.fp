// mode 1 - ambient lighting

attribute vec4 a_Color;

void main(void) {
	vec4 Iamb = clamp(gl_FrontLightProduct[0].ambient, 0.0, 1.0);
	
   	gl_FragColor = Iamb;    
}