component Mathf
{
    public const float Rad2Deg = 57.2957795130824f;
    public const float Deg2Rad = 0.0174532925199433f;

    public Mathf()
    {
    }

    public Vector3 NegateVector(Vector3 vec)
    {
        return makeVector3(-vec.x, -vec.y, -vec.z);
    }

    public Vector3 Normalize(Vector3 vec)
    {
        float magnitude = hsMathSqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z);
        if (magnitude > 0f)
        {
            vec = makeVector3(vec.x / magnitude, vec.y / magnitude, vec.z / magnitude);
        }
        else
        {
            vec = makeVector3(0, 0, 0);
        }

        return vec;
    }

    public Vector3 Cross(Vector3 vec1, Vector3 vec2)
    {
        float x = vec1.y * vec2.z - vec1.z * vec2.y;
        float y = vec1.z * vec2.x - vec1.x * vec2.z;
        float z = vec1.x * vec2.y - vec1.y * vec2.x;

        return makeVector3(x, y, z);
    }

    public float Dot(Vector3 vec1, Vector3 vec2)
    {
        return vec1.x * vec2.x + vec1.y * vec2.y + vec1.z * vec2.z;
    }

    public float Acos(float value)
    {
        if (value < -1f)
        {
            value = -1f;
        }
        else if (value > 1f)
        {
            value = 1f;
        }
        
        return hsMathAtan2(hsMathSqrt(1f - value * value), value);
    }

    public Vector3 AddVectors(Vector3 vec1, Vector3 vec2)
    {
        return makeVector3(vec1.x + vec2.x, vec1.y + vec2.y, vec1.z + vec2.z);
    }

    public Vector3 SubtractVectors(Vector3 vec1, Vector3 vec2)
    {
        return AddVectors(vec1, NegateVector(vec2));
    }

    public Vector3 MultiplyVectors(Vector3 vec1, Vector3 vec2)
    {
        float x = vec1.x * vec2.x;
        float y = vec1.y * vec2.y;
        float z = vec1.z * vec2.y;

        return makeVector3(x, y, z);
    }

    public Vector3 MultiplyV3F(Vector3 vec1, float value)
    {
        float x = vec1.x * value;
        float y = vec1.y * value;
        float z = vec1.z * value;

        return makeVector3(x, y, z);
    }

    public Quaternion QuaternionMultiply(Quaternion qua1, Quaternion qua2)
    {
        Quaternion qua3 = makeQuaternion(0, 0, 0, 0);
        qua3.x = qua1.x * qua2.w + qua1.y * qua2.z - qua1.z * qua2.y + qua1.w * qua2.x;
        qua3.y = -qua1.x * qua2.z + qua1.y * qua2.w + qua1.z * qua2.x + qua1.w * qua2.y;
        qua3.z = qua1.x * qua2.y - qua1.y * qua2.x + qua1.z * qua2.w + qua1.w * qua2.z;
        qua3.w = -qua1.x * qua2.x - qua1.y * qua2.y - qua1.z * qua2.z + qua1.w * qua2.w;
        return qua3;
    }

    public Vector3 MultiplyQV3(Quaternion qua, Vector3 vec)
    {
        Quaternion vectorQuaternion = makeQuaternion(vec.x, vec.y, vec.z, 0f);
        Quaternion inverseQuaternion = QuaternionMultiply(vectorQuaternion, Inverse(qua));
        Quaternion resultQuaternion = QuaternionMultiply(qua, inverseQuaternion);
        return makeVector3(resultQuaternion.x, resultQuaternion.y, resultQuaternion.z);
    }

    public Quaternion Inverse(Quaternion rotation)
    {
        Quaternion inverse = makeQuaternion(0f, 0f, 0f, 1f);
        float magnitudeSquared = Magnitude(rotation) * Magnitude(rotation);
        if (magnitudeSquared > 0f)
        {
            inverse = makeQuaternion(-rotation.x / magnitudeSquared, -rotation.y / magnitudeSquared, -rotation.z / magnitudeSquared, rotation.w / magnitudeSquared);
        }
        return inverse;
    }

    public float Magnitude(Quaternion qua)
    {
        return hsMathSqrt(qua.x * qua.x + qua.y * qua.y + qua.z * qua.z + qua.w * qua.w);
    }

    public float Clamp01(float value)
    {
        float result;
        if (value < 0f)
        {
            result = 0f;
        }
        else if (value > 1f)
        {
            result = 1f;
        }
        else
        {
            result = value;
        }
        return result;
    }
}

component Stringf
{
    public list<string> Split(string str, string separator)
    {
        list<string> result = new list<string>();
        int startIndex = 0;
        int separatorIndex = str.IndexOf(separator);

        if(str.IndexOf(separator) == -1)
        {
            result.Add(str);
        }
        else
        {
            while (separatorIndex != -1)
            {
                result.Add(str.SubString(startIndex, separatorIndex - startIndex));
                str = str.SubString(separatorIndex + 1, str.Length() - separatorIndex + 1);
                separatorIndex = str.IndexOf(separator);
                if(separatorIndex == -1)
                {
                    result.Add(str.SubString(startIndex, separatorIndex - startIndex));
                    break;
                }
            }
        }          
        return result;
    }

    public string ReplaceStringChar(string str, string targetChar, int charIndex)
    {
        int strLength = str.Length();
        string firstLetter = str.SubString(0, charIndex);
        string lastLetter = str.SubString(charIndex + 1, strLength - charIndex);

        return firstLetter + targetChar + lastLetter;
    }
    
    public list<string> ResezeList(list<string> li, int size)
    {
        list<string> result = new list<string>();
        int i;
        for(i = 0; i < size; i++)
        {
            result.Add(li[i]);
        }
        return result;
    }

    public list<string> SetDifference(list<string> li1, list<string> li2)
    {
        list<string> result = new list<string>();

        int i;
        for (i = 0; i < li1.Count(); i++)
        {
            bool found = false;
            int j;
            for(j = 0; j < li2.Count(); j++)
            {
                if(li1[i] == li2[j])
                {
                    found = true;
                    break;
                }
            }

            if (!found) {
                result.Add(li1[i]);
            }
        }
        return result;
    }

    public string FromInt(int i)
    {
        return "%d" % i;
    }

    public string FromFloat(float f)
    {
        return "%f" % f;
    }

    public string FromBool(bool bo)
    {
        string result;
        if(bo)
        {
            result = "true";
        }
        else
        {
            result = "false";
        }
        return result;
    }

    public bool ToBool(string str)
    {
        bool result;
        if(str == "false")
        {
            result = false;
        }
        if(str == "true")
        {
            result = true;
        }
        if(str != "true" && str != "false")
        {
            hsSystemOutput("parameter is not bool");
        }

        return result;
    }

    public float ToFloat(string str)
    {
        return float(str.ToInt());
    }

    public string FromVector3(Vector3 vec)
    {
        return "(%f, %f, %f)"% vec.x % vec.y % vec.z;
    }

    public Vector3 ToVector3(string str)
    {
        list<string> splitList = Split(str, ",");
        string x = splitList[0];
        string y = splitList[1];
        string z = splitList[2];
        x.RemoveAt(0);
        z.RemoveLast();
        
        return makeVector3(ToFloat(x),ToFloat(y),ToFloat(z));
    }
}

component Vector3f
{
    Mathf mathf;
    Quaternionf quaternionf;
    public Vector3 forward;
    public Vector3 back;

    public Vector3f()
    {
        mathf = new Mathf();
        quaternionf = new Quaternionf();
        forward = makeVector3(0, 0, 1);
        back = makeVector3(0, 0, -1);
    }

    public bool AreVectorComponentsEqual(Vector3 vec1, Vector3 vec2)
    {
        bool result;

        if (vec1.x == vec2.x && vec1.y == vec2.y && vec1.z == vec2.z) {
            result = true;
        }
        else {
            result = false;
        }
        return result;
    }

    public Vector3 Lerp(Vector3 startValue, Vector3 endValue, float t)
    {
        t = mathf.Clamp01(t);
        return mathf.AddVectors(startValue, mathf.MultiplyV3F(mathf.SubtractVectors(endValue, startValue), t));
    }
}

component Quaternionf
{
    Mathf mathf;
    public Quaternion identity;

    public Quaternionf()
    {
        mathf = new Mathf();
        identity = makeQuaternion(0f, 0f, 0f, 1f);
    }

    public Quaternion AngleAxis(float angle, Vector3 axis)
    {
        float halfAngleInRadians = angle * mathf.Deg2Rad * 0.5f;
        Vector3 normalizedAxis = mathf.Normalize(axis);
        float sin = hsMathSin(halfAngleInRadians);
        float cos = hsMathCos(halfAngleInRadians);

        return makeQuaternion(normalizedAxis.x * sin, normalizedAxis.y * sin, normalizedAxis.z * sin, cos);
    }

    public bool AreQuaternionComponentsEqual(Quaternion Qua1, Quaternion Qua2)
    {
        bool result;
        if (Qua1.x == Qua2.x && Qua1.y == Qua2.y && Qua1.z == Qua2.z && Qua1.w == Qua2.w) 
        {
            result = true;
        }
        else {
            result = false;
        }

        return result;
    }


}

component Transformf
{
    Mathf mathf;
    Quaternionf quaternionf;
    Vector3 hsBuck;

    public Transformf()
    {
        mathf = new Mathf();
        hsBuck = makeVector3(0, 0, -1);

        quaternionf = new Quaternionf();
    }

    public Quaternion LookAt(Item lookerItem, Vector3 direction)
    {
        Quaternion rotation = QuaternionFromToRotation(hsBuck, direction);
        lookerItem.SetQuaternion(rotation);
        return rotation;
    }

    Quaternion QuaternionFromToRotation(Vector3 fromDirection, Vector3 toDirection)
    {
        float angle = AngleBetweenVectors(fromDirection, toDirection);
        Vector3 crossVector = mathf.Cross(fromDirection, toDirection);
        Vector3 axis = mathf.Normalize(crossVector);
        Quaternion angleAxisRotation = quaternionf.AngleAxis(angle, axis);

        return angleAxisRotation;
    }

    float AngleBetweenVectors(Vector3 vec1, Vector3 vec2)
    {
        float dot = mathf.Dot(mathf.Normalize(vec1), mathf.Normalize(vec2));

        return mathf.Acos(dot) * mathf.Rad2Deg;
    }

    public Vector3 TransformVector(Player player, Vector3 vec)
    {
        Quaternion playerRotation = quaternionf.AngleAxis(player.GetRotate(), makeVector3(0,1,0));
        return mathf.MultiplyQV3(playerRotation, vec);
    }
}

component Itemf
{
    Mathf mathf;
    Vector3f vector3f;

    public Itemf()
    {
        mathf = new Mathf();
        vector3f = new Vector3f();
    }

    public Vector3 Forword(Item forwordItem)
    {
        Quaternion rotation = forwordItem.GetQuaternion();
        Vector3 forwardVector = mathf.MultiplyQV3(rotation, vector3f.forward);
        return mathf.Normalize(forwardVector);
    }
}

component Playerf
{
    Mathf mathf;

    public Playerf()
    {
        mathf = new Mathf();
    }

    public Vector3 Forword(Player player)
    {
        float yRotation = player.GetRotate();
        return makeVector3(hsMathSin(yRotation * mathf.Deg2Rad), 0, hsMathCos(yRotation * mathf.Deg2Rad));
    }

    public Vector3 Back(Player player)
    {
        float yRotation = player.GetRotate() + 180f;
        return makeVector3(hsMathSin(yRotation * mathf.Deg2Rad), 0, hsMathCos(yRotation * mathf.Deg2Rad));
    }
}