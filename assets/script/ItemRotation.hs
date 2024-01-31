component ItemRotater {
	Mathf mathf;
	Item m_Item;
	float time;
	float speed;
	float rotation;
	Quaternion updateQuaternion;
	Quaternion startQuaternion;

	public ItemRotater()
	{
		mathf = new Mathf();
		
		m_Item = hsItemGetSelf;
		time = hsSystemGetDeltaTime();
		speed = 1.2;
		rotation = 0;
		startQuaternion = m_Item.GetQuaternion();
	}

	public void Update()
	{
		time += hsSystemGetDeltaTime();
		rotation += speed;
		
		updateQuaternion = mathf.QuaternionMultiply(startQuaternion, makeQuaternionEuler(0, 0, rotation));
		m_Item.SetQuaternion(updateQuaternion);
	}
}
