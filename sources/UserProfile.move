module AptosProfile::User {

    use std::string::{String, utf8};
    
    use std::signer;
    
    struct UserProfile has key { data: String}
    
    public entry fun set_data(account: &signer, raw_data : vector<u8>) acquires UserProfile{
        let data = utf8(raw_data);
        let user_addr = signer::address_of(account);

        if(!exists<UserProfile>(user_addr)){
            let user_profile = UserProfile{data:data};
            move_to(account,user_profile)
        } else{
            let existing_user_profile = borrow_global_mut<UserProfile>(user_addr);
            existing_user_profile.data=data
        }
    }
    public fun get_data(addr: address): String acquires UserProfile {
        borrow_global<UserProfile>(addr).data
    }

}