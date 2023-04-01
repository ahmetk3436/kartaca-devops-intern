using System;

public class Program
{
    public static void Main()
    {
        string encryptedMessage = "{\"type\":\"HELLO\",\"hint\":\"Use: a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z. input : ab,z result : zy,a\",\"message\":\"Povzhv hvmw z nvhhztv drgs xfiivmg hvhhrlm rm qhlm ulinzg erz gsrh vcznkov : {\\\"gbkv\\\":\\\"REGISTER\\\",\\\"mznv\\\":\\\"blfi mznv\\\",\\\"hfimznv\\\":\\\"blfi hfimznv\\\",\\\"vnzro\\\":\\\"blfi vnzro zwwivhh\\\",\\\"ivtrhgizgrlmKvb\\\":\\\"ccc\\\"}. Kvvk orhgvmrmt mvd nvhhztv uli gzhp xlmgvmg! Ylfi ivtrhgizgrlmKvb : 50229wv1z064wu8y13uzzzuxw56957u0717wv231w1yyz1u89452yx5681800139\"}";

        string decryptedMessage = Decrypt(encryptedMessage);

        Console.WriteLine(decryptedMessage);
    }

    public static string Decrypt(string encryptedMessage)
    {
        string decryptedMessage = "";
        foreach (char c in encryptedMessage)
        {
            if (Char.IsLetter(c))
            {
                char decryptedChar = (char)(c - 3);
                if (decryptedChar < 'a')
                {
                    decryptedChar = (char)(decryptedChar + 26);
                }
                decryptedMessage += decryptedChar;
            }
            else
            {
                decryptedMessage += c;
            }
        }
        return decryptedMessage;
    }
}
