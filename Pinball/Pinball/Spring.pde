class Spring {

  // This is the box2d object we need to create
  MouseJoint mouseJoint;

  Spring() {
    mouseJoint = null;
  }

  void update(float x, float y) {
    if (mouseJoint != null) {
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
      mouseJoint.setTarget(mouseWorld);
    }
  }

  void bind(float x, float y, Launcher launcher) {
    // Define the joint
    MouseJointDef md = new MouseJointDef();
    // Body A is just a fake ground body for simplicity (there isn't anything at the mouse)
    md.bodyA = box2d.getGroundBody();
    // Body 2 is the box's boxy
    md.bodyB = launcher.body;
    // Get the mouse location in world coordinates
    Vec2 mp = box2d.coordPixelsToWorld(x,y);
    // And that's the target
    md.target.set(mp);
    // Some stuff about how strong and bouncy the spring should be
    md.maxForce = 1000.0 * launcher.body.m_mass;
    md.frequencyHz = 5.0;
    md.dampingRatio = 0.9;

    mouseJoint = (MouseJoint) box2d.world.createJoint(md);
  }

  void destroy() {
    if (mouseJoint != null) {
      box2d.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    }
  }

}
