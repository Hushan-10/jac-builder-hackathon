import from "@jac/runtime" { Link, useNavigate, useRouter, jacLogin, jacSignup }


def is_valid_email(v: str) -> bool {
    s = (v or "").strip();
    return (len(s) >= 5) and s.includes("@") and s.includes(".");
}


def:pub page() -> JsxElement {
    router = useRouter();
    navigate = useNavigate();

    mode_q = (router["search"] or "");
    is_signup_default = mode_q.includes("mode=signup");

    has is_signup: bool = is_signup_default;

    has role: str = "Traveler";
    has full_name: str = "";
    has email: str = "";
    has password: str = "";

    has error: str = "";
    has loading: bool = False;

    def set_mode_signup() -> None {
        is_signup = True;
        error = "";
    }

    def set_mode_signin() -> None {
        is_signup = False;
        error = "";
    }

    def on_full_name(e: any) -> None { full_name = e.target.value; }
    def on_email(e: any) -> None { email = e.target.value; }
    def on_password(e: any) -> None { password = e.target.value; }

    def on_role_traveler() -> None { role = "Traveler"; }
    def on_role_guide() -> None { role = "Guide / Vendor"; }

    async def on_submit(e: any) -> None {
        e.preventDefault();
        error = "";

        em = (email or "").strip();
        pw = (password or "").strip();
        nm = (full_name or "").strip();
        rl = (role or "").strip();

        if is_signup {
            if not nm { error = "Full name is required."; return; }
            if not em { error = "Email is required."; return; }
            if not is_valid_email(em) { error = "Please enter a valid email."; return; }
            if not pw { error = "Password is required."; return; }
            if not rl { error = "Please select a role."; return; }

            loading = True;
            try {
                res = await jacSignup(em, pw);
                if res and (res["success"] or res == True) {
                    navigate("/dashboard");
                } else {
                    error = (res and res["error"]) or "Signup failed. Please try again.";
                }
            } except Exception as ex {
                error = "An error occurred during signup.";
            }
            loading = False;
            return;
        }

        # sign in
        if not em { error = "Email is required."; return; }
        if not is_valid_email(em) { error = "Please enter a valid email."; return; }
        if not pw { error = "Password is required."; return; }

        loading = True;
        try {
            ok = await jacLogin(em, pw);
            if ok {
                navigate("/dashboard");
            } else {
                error = "Invalid credentials.";
            }
        } except Exception as ex {
            error = "An error occurred during sign in.";
        }
        loading = False;
    }

    left_img = "https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=2400&q=80";

    return (
        <div className="min-h-screen w-full grid grid-cols-1 lg:grid-cols-2">
            <div className="relative hidden lg:block">
                <div
                    className="absolute inset-0"
                    style={{"backgroundImage": "url(" + left_img + ")", "backgroundSize": "cover", "backgroundPosition": "center"}}
                />
                <div className="absolute inset-0" style={{"background": "linear-gradient(180deg, rgba(7,20,39,0.78) 0%, rgba(7,20,39,0.62) 45%, rgba(7,20,39,0.55) 100%)"}} />

                <div className="relative h-full flex items-center">
                    <div className="px-14">
                        <div className="inline-flex items-center gap-3">
                            <div className="h-11 w-11 rounded-2xl border border-white/20 bg-white/10 backdrop-blur flex items-center justify-center">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                    <path d="M3 19L12 5l9 14H3Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                </svg>
                            </div>
                            <div className="text-4xl text-white" style={{"fontFamily": "var(--font-display)"}}>SwissEscape</div>
                        </div>
                        <p className="mt-6 max-w-md text-white/80 text-base leading-relaxed">
                            Discover Switzerland&apos;s most extraordinary experiences. Your alpine adventure begins here.
                        </p>
                    </div>
                </div>
            </div>

            <div className="bg-white flex items-center justify-center px-6 py-12">
                <div className="w-full max-w-[28rem]">
                    <div>
                        <h1 className="text-4xl md:text-5xl leading-tight text-foreground" style={{"fontFamily": "var(--font-display)"}}>
                            {is_signup and "Create an account" or "Welcome back"}
                        </h1>
                        <p className="mt-2 text-sm text-muted-foreground">
                            {is_signup and "Join SwissEscape today" or "Sign in to access your trips"}
                        </p>
                    </div>

                    <div className="mt-8 rounded-[var(--radius-xl)] border border-border bg-white shadow-card p-7 md:p-8">
                        {error and (
                            <div className="mb-5 rounded-xl border px-4 py-3 text-sm" style={{"backgroundColor": "rgba(239,68,68,0.08)", "borderColor": "rgba(239,68,68,0.25)", "color": "rgb(185,28,28)"}}>
                                {error}
                            </div>
                        )}

                        <form onSubmit={on_submit} className="flex flex-col gap-4">
                            {is_signup and (
                                <>
                                    <div className="grid grid-cols-2 gap-3">
                                        <button
                                            type="button"
                                            onClick={on_role_traveler}
                                            className={"h-11 rounded-xl border text-sm font-semibold transition-colors " + ((role == "Traveler") and "bg-primary text-primary-foreground border-primary" or "bg-white text-foreground border-border hover:bg-muted")}
                                        >
                                            Traveler
                                        </button>
                                        <button
                                            type="button"
                                            onClick={on_role_guide}
                                            className={"h-11 rounded-xl border text-sm font-semibold transition-colors " + ((role == "Guide / Vendor") and "bg-primary text-primary-foreground border-primary" or "bg-white text-foreground border-border hover:bg-muted")}
                                        >
                                            Guide / Vendor
                                        </button>
                                    </div>

                                    <div>
                                        <label className="block text-xs font-medium uppercase tracking-[0.14em] text-muted-foreground mb-2">Full Name</label>
                                        <input
                                            className="w-full h-12 rounded-xl border border-border bg-background text-foreground px-4 text-sm outline-none transition-[border-color,box-shadow] duration-150 placeholder:text-muted-foreground focus:border-primary focus:ring-[3px] focus:ring-primary/12"
                                            value={full_name}
                                            onChange={on_full_name}
                                            placeholder="Your name"
                                            autoComplete="name"
                                        />
                                    </div>
                                </>
                            )}

                            <div>
                                <label className="block text-xs font-medium uppercase tracking-[0.14em] text-muted-foreground mb-2">Email address</label>
                                <div className="relative">
                                    <div className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                            <polyline points="22,6 12,13 2,6" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                        </svg>
                                    </div>
                                    <input
                                        className="w-full h-12 rounded-xl border border-border bg-background text-foreground pl-10 pr-4 text-sm outline-none transition-[border-color,box-shadow] duration-150 placeholder:text-muted-foreground focus:border-primary focus:ring-[3px] focus:ring-primary/12"
                                        value={email}
                                        onChange={on_email}
                                        placeholder="Email address"
                                        autoComplete="username"
                                    />
                                </div>
                            </div>

                            <div>
                                <label className="block text-xs font-medium uppercase tracking-[0.14em] text-muted-foreground mb-2">Password</label>
                                <div className="relative">
                                    <div className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2" stroke="currentColor" strokeWidth="2" />
                                        </svg>
                                    </div>
                                    <input
                                        className="w-full h-12 rounded-xl border border-border bg-background text-foreground pl-10 pr-4 text-sm outline-none transition-[border-color,box-shadow] duration-150 placeholder:text-muted-foreground focus:border-primary focus:ring-[3px] focus:ring-primary/12"
                                        type="password"
                                        value={password}
                                        onChange={on_password}
                                        placeholder="••••••••"
                                        autoComplete={is_signup and "new-password" or "current-password"}
                                    />
                                </div>
                            </div>

                            {(not is_signup) and (
                                <div className="flex justify-end">
                                    <button type="button" className="bg-transparent border-0 text-sm text-muted-foreground hover:text-foreground cursor-pointer p-0">
                                        Forgot password?
                                    </button>
                                </div>
                            )}

                            <button
                                className="w-full h-12 inline-flex items-center justify-center gap-2 rounded-xl text-sm font-semibold cursor-pointer transition-opacity duration-150 bg-primary text-primary-foreground border border-primary hover:opacity-95 disabled:opacity-60"
                                type="submit"
                                disabled={loading}
                            >
                                {loading and (is_signup and "Creating..." or "Signing in...") or (is_signup and "Create Account" or "Sign In")}
                                <span className="text-base">→</span>
                            </button>

                            <div className="flex items-center gap-4 my-2">
                                <div className="h-px flex-1 bg-border" />
                                <div className="text-xs uppercase tracking-[0.18em] text-muted-foreground">or continue with</div>
                                <div className="h-px flex-1 bg-border" />
                            </div>

                            <div className="grid grid-cols-2 gap-3">
                                <button
                                    type="button"
                                    className="h-11 rounded-xl border border-border bg-white hover:bg-muted transition-colors text-sm font-semibold inline-flex items-center justify-center gap-2"
                                >
                                    <span style={{"color": "var(--color-gold)"}}>G</span>
                                    Google
                                </button>
                                <button
                                    type="button"
                                    className="h-11 rounded-xl border border-border bg-white hover:bg-muted transition-colors text-sm font-semibold inline-flex items-center justify-center gap-2"
                                >
                                    <span></span>
                                    Apple
                                </button>
                            </div>
                        </form>

                        <div className="mt-6 text-center text-sm text-muted-foreground">
                            {is_signup and "Already have an account? " or "Don\'t have an account? "}
                            <button
                                type="button"
                                onClick={is_signup and set_mode_signin or set_mode_signup}
                                className="bg-transparent border-0 text-primary font-semibold cursor-pointer underline p-0"
                            >
                                {is_signup and "Sign in" or "Sign up"}
                            </button>
                        </div>

                        <div className="mt-4 text-center">
                            <Link to="/" className="text-sm text-muted-foreground hover:text-foreground">
                                ← Back to homepage
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
