default
{
    state_entry()
    {
        llSay(0, "Hello, Avatar!");
    }
    touch_end(integer total_number)
    {
        llSay(0, "Touched.");
    }
}
