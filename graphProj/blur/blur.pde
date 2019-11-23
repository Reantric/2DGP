PShader blur;
 
void setup() {
    size(600, 600, P2D);
    initBlur();
}
 
void draw() {
    rect(mouseX - 20, mouseY - 20, 40, 40);
    filter(blur);
}
 
void initBlur() {
    String[] vertSource = {
        "uniform mat4 transform;",
 
        "attribute vec4 vertex;",
        "attribute vec2 texCoord;",
 
        "varying vec2 vertTexCoord;",
 
        "void main() {",
            "vertTexCoord = vec2(texCoord.x, 1.0 - texCoord.y);",
            "gl_Position = transform * vertex;",
        "}"
    };
    String[] fragSource = {
        "uniform sampler2D texture;",
        "uniform vec2 texOffset;",
 
        "varying vec2 vertTexCoord;",
 
        "void main() {",
            "gl_FragColor  = texture2D(texture, vertTexCoord - 0.5 * texOffset);",
            "gl_FragColor += texture2D(texture, vertTexCoord - 0.5 * vec2(texOffset.x, -texOffset.y));",
            "gl_FragColor += texture2D(texture, vertTexCoord + 0.5 * vec2(texOffset.x, -texOffset.y));",
            "gl_FragColor += texture2D(texture, vertTexCoord + 0.5 * texOffset);",
            "gl_FragColor *= 0.25;",
        "}"
    };
    blur = new PShader(this, vertSource, fragSource);
}
