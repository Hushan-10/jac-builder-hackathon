import from "@jac/runtime" { Link }


def:pub page() -> JsxElement {
    tabs = ["All", "Hotel", "Chalet", "Apartment", "Lodge", "Resort"];

    has selectedType: str = "All";

    stays = [
        {
            "id": "alpine-luxury-chalet",
            "title": "Alpine Luxury Chalet",
            "type": "Chalet",
            "location": "Grindelwald",
            "rating": 4.9,
            "reviews": 128,
            "price": "CHF 450 / night",
            "features": ["Wi‑Fi", "Fireplace", "Hot Tub", "Mountain View"],
            "badge": "Featured",
            "image": "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "id": "engadin-palace-suite",
            "title": "Engadin Palace Suite",
            "type": "Resort",
            "location": "St. Moritz",
            "rating": 4.9,
            "reviews": 256,
            "price": "CHF 680 / night",
            "features": ["Spa", "Restaurant", "Pool", "Concierge"],
            "badge": "Featured",
            "image": "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "id": "lakeside-boutique-hotel",
            "title": "Lakeside Boutique Hotel",
            "type": "Hotel",
            "location": "Lucerne",
            "rating": 4.8,
            "reviews": 312,
            "price": "CHF 350 / night",
            "features": ["Lake View", "Restaurant", "Spa", "Bar"],
            "badge": "Featured",
            "image": "https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "id": "matterhorn-lodge",
            "title": "Matterhorn Lodge",
            "type": "Lodge",
            "location": "Zermatt",
            "rating": 4.8,
            "reviews": 167,
            "price": "CHF 380 / night",
            "features": ["Ski Access", "Sauna", "Restaurant", "Wi‑Fi"],
            "badge": "",
            "image": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "id": "interlaken-river-suite",
            "title": "Interlaken River Suite",
            "type": "Hotel",
            "location": "Interlaken",
            "rating": 4.6,
            "reviews": 203,
            "price": "CHF 290 / night",
            "features": ["River View", "Pool", "Gym", "Breakfast"],
            "badge": "",
            "image": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "id": "mountain-view-apartment",
            "title": "Mountain View Apartment",
            "type": "Apartment",
            "location": "Grindelwald",
            "rating": 4.7,
            "reviews": 89,
            "price": "CHF 220 / night",
            "features": ["Wi‑Fi", "Kitchen", "Parking", "Balcony"],
            "badge": "",
            "image": "https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=2400&q=80"
        }
    ];

    def type_match(s: dict) -> bool {
        if selectedType == "All" { return True; }
        return String(s["type"] or "").toLowerCase() == String(selectedType).toLowerCase();
    }

    filtered = [s for s in stays if type_match(s)];

    def set_tab(t: str) -> None {
        selectedType = t;
    }

    # ----------------------------
    # Booking flow state
    # ----------------------------
    has bookingOpen: bool = False;
    has bookingStep: int = 1;
    has selectedStay: dict = {};

    has checkIn: str = "";
    has checkOut: str = "";
    has guests: int = 2;

    has fullName: str = "";
    has email: str = "";
    has phone: str = "";

    has step1Error: str = "";
    has step2Error: str = "";

    has bookingRef: str = "";

    has toastOpen: bool = False;
    has toastTitle: str = "";
    has toastMessage: str = "";

    def parse_price_per_night(stay: dict) -> int {
        p = str(stay["price"] or "");
        digits = "";
        for ch in p {
            if (ch >= "0") and (ch <= "9") { digits = digits + ch; }
            elif digits { break; }
        }
        return int(digits) if digits else 0;
    }

    def date_to_days(d: str) -> int {
        # expects YYYY-MM-DD
        if not d { return 0; }
        parts = d.split("-");
        if len(parts) != 3 { return 0; }
        y = int(parts[0] or 0);
        m = int(parts[1] or 0);
        day = int(parts[2] or 0);
        if (y <= 0) or (m <= 0) or (day <= 0) { return 0; }
        # Rata Die style day count (Gregorian)
        a = (14 - m) // 12;
        y2 = y + 4800 - a;
        m2 = m + (12 * a) - 3;
        return day + ((153 * m2 + 2) // 5) + (365 * y2) + (y2 // 4) - (y2 // 100) + (y2 // 400) - 32045;
    }

    def nights_count() -> int {
        if (not checkIn) or (not checkOut) { return 0; }
        d1 = date_to_days(checkIn);
        d2 = date_to_days(checkOut);
        if (d1 <= 0) or (d2 <= 0) { return 0; }
        n = d2 - d1;
        return n if n > 0 else 0;
    }

    def total_amount() -> int {
        rate = parse_price_per_night(selectedStay);
        n = nights_count();
        return rate * n;
    }

    def open_booking(stay: dict) -> None {
        selectedStay = stay or {};
        bookingOpen = True;
        bookingStep = 1;
        checkIn = "";
        checkOut = "";
        guests = 2;
        fullName = "";
        email = "";
        phone = "";
        step1Error = "";
        step2Error = "";
        bookingRef = "";
        toastOpen = False;
    }

    def close_booking() -> None {
        bookingOpen = False;
        bookingStep = 1;
        selectedStay = {};
        checkIn = "";
        checkOut = "";
        guests = 2;
        fullName = "";
        email = "";
        phone = "";
        step1Error = "";
        step2Error = "";
        bookingRef = "";
    }

    def inc_guests() -> None { guests = guests + 1; }

    def dec_guests() -> None {
        guests = guests - 1 if guests > 1 else 1;
    }

    def on_checkin(e: any) -> None { checkIn = e.target.value; step1Error = ""; }
    def on_checkout(e: any) -> None { checkOut = e.target.value; step1Error = ""; }

    def validate_step1() -> bool {
        n = nights_count();
        if n <= 0 {
            step1Error = "Please select valid dates (minimum 1 night).";
            return False;
        }
        step1Error = "";
        return True;
    }

    def continue_step1(e: any = None) -> None {
        if e { e.preventDefault(); }
        if validate_step1() { bookingStep = 2; }
    }

    def on_fullname(e: any) -> None { fullName = e.target.value; step2Error = ""; }
    def on_email(e: any) -> None { email = e.target.value; step2Error = ""; }
    def on_phone(e: any) -> None { phone = e.target.value; step2Error = ""; }

    def back_step2(e: any = None) -> None {
        if e { e.preventDefault(); }
        bookingStep = 1;
        step2Error = "";
    }

    def validate_step2() -> bool {
        if (not str(fullName or "").strip()) or (not str(email or "").strip()) or (not str(phone or "").strip()) {
            step2Error = "Please fill in Full Name, Email, and Phone.";
            return False;
        }
        step2Error = "";
        return True;
    }

    def make_ref() -> str {
        # simple deterministic-ish ref
        base = str(selectedStay["id"] or "stay").replace("-", "").toUpperCase();
        tail = str(date_to_days(checkIn) + date_to_days(checkOut) + guests + total_amount());
        tail = tail[-7:] if len(tail) > 7 else tail;
        return "SE-" + (base[:3] if len(base) >= 3 else base) + tail;
    }

    def pay_step2(e: any = None) -> None {
        if e { e.preventDefault(); }
        if not validate_step1() { bookingStep = 1; return; }
        if not validate_step2() { return; }
        bookingRef = make_ref();
        bookingStep = 3;
        toastTitle = "Stay booked!";
        toastMessage = "Your reservation at " + str(selectedStay["title"] or "") + " is confirmed.";
        toastOpen = True;
    }

    def done_step3(e: any = None) -> None {
        if e { e.preventDefault(); }
        close_booking();
    }

    def close_toast() -> None { toastOpen = False; }

    def modal_shell(content: JsxElement) -> JsxElement {
        return (
            <div className="fixed inset-0 z-50">
                <div className="absolute inset-0 bg-black/55" onClick={close_booking} />
                <div className="absolute inset-0 flex items-center justify-center p-4">
                    <div className="w-full max-w-[38rem] bg-white rounded-3xl shadow-[0_30px_80px_rgba(0,0,0,0.25)] border border-black/5 overflow-hidden">
                        {content}
                    </div>
                </div>
            </div>
        );
    }

    def close_icon() -> JsxElement {
        return (
            <button
                type="button"
                onClick={close_booking}
                className="h-10 w-10 rounded-full grid place-items-center hover:bg-black/5 transition-colors"
                aria-label="Close"
            >
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.75)"}}>
                    <path d="M18 6L6 18" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                    <path d="M6 6l12 12" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                </svg>
            </button>
        );
    }

    def step_header() -> JsxElement {
        return (
            <div className="px-8 pt-7 pb-4">
                <div className="flex items-start justify-between gap-4">
                    <div>
                        <div className="text-2xl text-[#101828]" style={{"fontFamily": "var(--font-display)"}}>
                            {"Book " + str(selectedStay["title"] or "")}
                        </div>
                        <div className="mt-1 text-sm text-[#667085]">{str(selectedStay["location"] or "")}</div>
                    </div>
                    {close_icon()}
                </div>
            </div>
        );
    }

    def step1_modal() -> JsxElement {
        rate = parse_price_per_night(selectedStay);
        n = nights_count();
        n_text = str(n) + (" night" if n == 1 else " nights");
        total = total_amount();

        return modal_shell(
            <div>
                {step_header()}

                <div className="px-8 pb-8">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                        <div>
                            <div className="text-sm font-semibold text-[#101828]">Check-in</div>
                            <div className="mt-2 relative">
                                <input
                                    type="date"
                                    value={checkIn}
                                    onChange={on_checkin}
                                    className="w-full h-12 rounded-2xl px-4 text-sm outline-none border border-black/10 bg-white focus:border-black/20 focus:ring-[3px] focus:ring-black/5"
                                />
                            </div>
                        </div>
                        <div>
                            <div className="text-sm font-semibold text-[#101828]">Check-out</div>
                            <div className="mt-2 relative">
                                <input
                                    type="date"
                                    value={checkOut}
                                    onChange={on_checkout}
                                    className="w-full h-12 rounded-2xl px-4 text-sm outline-none border border-black/10 bg-white focus:border-black/20 focus:ring-[3px] focus:ring-black/5"
                                />
                            </div>
                        </div>
                    </div>

                    <div className="mt-6">
                        <div className="text-sm font-semibold text-[#101828]">Guests</div>
                        <div className="mt-3 flex items-center gap-4">
                            <button
                                type="button"
                                onClick={dec_guests}
                                className="h-12 w-12 rounded-2xl border border-black/10 bg-white hover:bg-black/5 transition-colors text-lg"
                                aria-label="Decrease guests"
                            >
                                -
                            </button>
                            <div className="w-12 text-center text-lg font-semibold text-[#101828]">{str(guests)}</div>
                            <button
                                type="button"
                                onClick={inc_guests}
                                className="h-12 w-12 rounded-2xl border border-black/10 bg-white hover:bg-black/5 transition-colors text-lg"
                                aria-label="Increase guests"
                            >
                                +
                            </button>
                        </div>
                    </div>

                    {step1Error and (
                        <div className="mt-5 rounded-2xl border border-red-500/25 bg-red-500/5 px-4 py-3 text-sm text-red-700">
                            {step1Error}
                        </div>
                    )}

                    <div className="mt-7 rounded-3xl bg-[#F8FAFC] border border-black/5 p-5">
                        <div className="flex items-center justify-between text-sm text-[#667085]">
                            <div>{"CHF " + str(rate) + " × " + (n_text if n > 0 else "—")}</div>
                            <div className="text-[#101828] font-semibold">{"CHF " + str(total) if n > 0 else "—"}</div>
                        </div>
                        <div className="mt-4 pt-4 border-t border-black/5 flex items-center justify-between">
                            <div className="text-base font-semibold text-[#101828]">Total</div>
                            <div className="text-base font-semibold" style={{"color": "#1F7A5A"}}>
                                {"CHF " + str(total) if n > 0 else "CHF 0"}
                            </div>
                        </div>
                    </div>

                    <button
                        type="button"
                        onClick={continue_step1}
                        className="mt-7 w-full h-12 rounded-2xl text-sm font-semibold text-white shadow-[0_18px_40px_rgba(7,20,39,0.22)] hover:opacity-95 transition-opacity"
                        style={{"backgroundColor": "#0B2A4A"}}
                        disabled={nights_count() <= 0}
                    >
                        Continue
                    </button>
                </div>
            </div>
        );
    }

    def step2_modal() -> JsxElement {
        total = total_amount();
        return modal_shell(
            <div>
                {step_header()}
                <div className="px-8 pb-8">
                    <div className="grid grid-cols-1 gap-4">
                        <div>
                            <label className="block text-sm font-semibold text-[#101828]">Full Name</label>
                            <input
                                value={fullName}
                                onChange={on_fullname}
                                className="mt-2 w-full h-12 rounded-2xl px-4 text-sm outline-none border border-black/10 bg-white focus:border-black/20 focus:ring-[3px] focus:ring-black/5"
                                placeholder="Your name"
                            />
                        </div>
                        <div>
                            <label className="block text-sm font-semibold text-[#101828]">Email</label>
                            <input
                                value={email}
                                onChange={on_email}
                                className="mt-2 w-full h-12 rounded-2xl px-4 text-sm outline-none border border-black/10 bg-white focus:border-black/20 focus:ring-[3px] focus:ring-black/5"
                                placeholder="you@example.com"
                            />
                        </div>
                        <div>
                            <label className="block text-sm font-semibold text-[#101828]">Phone</label>
                            <input
                                value={phone}
                                onChange={on_phone}
                                className="mt-2 w-full h-12 rounded-2xl px-4 text-sm outline-none border border-black/10 bg-white focus:border-black/20 focus:ring-[3px] focus:ring-black/5"
                                placeholder="+41 ..."
                            />
                        </div>
                    </div>

                    {step2Error and (
                        <div className="mt-5 rounded-2xl border border-red-500/25 bg-red-500/5 px-4 py-3 text-sm text-red-700">
                            {step2Error}
                        </div>
                    )}

                    <div className="mt-7 flex items-center gap-3">
                        <button
                            type="button"
                            onClick={back_step2}
                            className="h-12 flex-1 rounded-2xl text-sm font-semibold border border-black/10 bg-white hover:bg-black/5 transition-colors"
                            style={{"color": "rgba(7,20,39,0.85)"}}
                        >
                            Back
                        </button>
                        <button
                            type="button"
                            onClick={pay_step2}
                            className="h-12 flex-[1.2] rounded-2xl text-sm font-semibold text-white shadow-[0_18px_40px_rgba(31,122,90,0.22)] hover:opacity-95 transition-opacity"
                            style={{"backgroundColor": "#1F7A5A"}}
                        >
                            {"Pay CHF " + str(total)}
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    def step3_modal() -> JsxElement {
        total = total_amount();
        summary = (
            str(checkIn) + " → " + str(checkOut) + " · " + str(guests) + " guests"
        );

        return modal_shell(
            <div>
                <div className="px-8 pt-7 pb-4">
                    <div className="flex items-start justify-between gap-4">
                        <div>
                            <div className="text-2xl text-[#101828]" style={{"fontFamily": "var(--font-display)"}}>
                                Booking Confirmed!
                            </div>
                            <div className="mt-1 text-sm text-[#667085]">Your Swiss retreat awaits</div>
                        </div>
                        {close_icon()}
                    </div>
                </div>

                <div className="px-8 pb-8">
                    <div className="flex justify-center py-3">
                        <div className="h-16 w-16 rounded-full grid place-items-center" style={{"backgroundColor": "rgba(31,122,90,0.12)", "color": "#1F7A5A"}}>
                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M20 6L9 17l-5-5" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" />
                            </svg>
                        </div>
                    </div>

                    <div className="text-center">
                        <div className="text-xl text-[#101828]" style={{"fontFamily": "var(--font-display)"}}>
                            {str(selectedStay["title"] or "")}
                        </div>
                        <div className="mt-2 text-sm text-[#667085]">{summary}</div>
                    </div>

                    <div className="mt-7 rounded-3xl border border-black/5 bg-[#F8FAFC] p-5">
                        <div className="flex items-center justify-between">
                            <div className="text-sm font-semibold text-[#101828]">Total Paid</div>
                            <div className="text-lg font-semibold" style={{"color": "#1F7A5A"}}>
                                {"CHF " + str(total)}
                            </div>
                        </div>
                        <div className="mt-3 text-xs text-[#667085]">{"Ref: " + str(bookingRef or "")}</div>
                    </div>

                    <button
                        type="button"
                        onClick={done_step3}
                        className="mt-7 w-full h-12 rounded-2xl text-sm font-semibold text-white shadow-[0_18px_40px_rgba(7,20,39,0.22)] hover:opacity-95 transition-opacity"
                        style={{"backgroundColor": "#0B2A4A"}}
                    >
                        Done
                    </button>
                </div>
            </div>
        );
    }

    def toast() -> JsxElement {
        return (
            <div className="fixed z-[60] right-4 top-4 w-[22rem]">
                <div className="rounded-2xl border border-black/10 bg-white shadow-[0_18px_50px_rgba(16,24,40,0.18)] p-4">
                    <div className="flex items-start justify-between gap-3">
                        <div>
                            <div className="text-sm font-semibold text-[#101828]">{toastTitle}</div>
                            <div className="mt-1 text-sm text-[#667085]">{toastMessage}</div>
                        </div>
                        <button type="button" onClick={close_toast} className="h-8 w-8 rounded-full grid place-items-center hover:bg-black/5 transition-colors" aria-label="Close toast">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.65)"}}>
                                <path d="M18 6L6 18" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                <path d="M6 6l12 12" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen se-bg">
            <div className="bg-white/70 border-b border-border">
                <div className="max-w-6xl mx-auto px-4 py-5">
                    <nav className="flex items-center justify-between">
                        <Link to="/" className="inline-flex items-center gap-3">
                            <div className="h-9 w-9 rounded-xl border border-border bg-white/70 flex items-center justify-center">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                    <path d="M3 19L12 5l9 14H3Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                </svg>
                            </div>
                            <div className="text-xl" style={{"fontFamily": "var(--font-display)"}}>SwissEscape</div>
                        </Link>

                        <div className="hidden md:flex items-center gap-10 text-sm text-foreground/80">
                            <Link to="/destinations" className="hover:text-foreground transition-colors">Destinations</Link>
                            <Link to="/experiences" className="hover:text-foreground transition-colors">Experiences</Link>
                            <Link to="/stays" className="text-foreground hover:text-foreground transition-colors">Stays</Link>
                            <Link to="/dashboard" className="hover:text-foreground transition-colors">Dashboard</Link>
                        </div>

                        <div className="flex items-center gap-4">
                            <Link to="/login" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Sign In</Link>
                            <Link
                                to="/signup"
                                className="h-10 px-5 inline-flex items-center justify-center rounded-full text-sm font-semibold shadow-soft"
                                style={{"backgroundColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                            >
                                Get Started
                            </Link>
                        </div>
                    </nav>
                </div>
            </div>

            <header className="py-16 md:py-20" style={{"backgroundColor": "#071427"}}>
                <div className="max-w-6xl mx-auto px-4">
                    <div className="text-center">
                        <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                            PREMIUM STAYS
                        </div>
                        <h1 className="mt-5 text-5xl md:text-6xl text-white leading-[1.02]" style={{"fontFamily": "var(--font-display)"}}>
                            Where to Stay in Switzerland
                        </h1>
                        <p className="mt-5 max-w-3xl mx-auto text-base md:text-lg leading-relaxed text-white/80">
                            From luxury chalets to lakeside boutique hotels — find your perfect Swiss retreat.
                        </p>
                    </div>
                </div>
            </header>

            <section className="bg-white/60 border-b border-border">
                <div className="max-w-6xl mx-auto px-4 py-6">
                    <div className="flex items-center gap-3 overflow-x-auto">
                        {[
                            <button
                                key={t}
                                type="button"
                                onClick={lambda e: set_tab(t)}
                                className={
                                    "h-10 px-5 rounded-full text-sm font-medium border transition-colors whitespace-nowrap "
                                    + (
                                        "bg-[#071427] text-white border-[#071427]"
                                        if selectedType == t
                                        else "bg-white/70 text-foreground/70 border-border hover:text-foreground"
                                    )
                                }
                            >
                                {t}
                            </button>
                            for t in tabs
                        ]}
                    </div>
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 py-12 md:py-14">
                <div className="grid grid-cols-1 md:grid-cols-3 gap-7">
                    {[
                        <div key={s["id"]} className="group rounded-[var(--radius-xl)] bg-white/70 border border-border shadow-soft hover:shadow-card transition-[box-shadow,transform] duration-300 hover:-translate-y-1 overflow-hidden">
                            <div className="relative overflow-hidden rounded-[var(--radius-xl)]">
                                <div className="h-64 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]" style={{"backgroundImage": "url(" + (s["image"] or "") + ")"}} />
                                <div className="absolute inset-0 bg-gradient-to-t from-black/55 via-black/10 to-black/0" />

                                <div className="absolute top-4 right-4 flex items-center gap-2">
                                    <button type="button" className="h-9 w-9 rounded-full bg-white/85 border border-white/60 inline-flex items-center justify-center shadow-soft">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.85)"}}>
                                            <path d="M20.8 4.6c-1.6-1.6-4.2-1.6-5.8 0L12 7.6 9 4.6C7.4 3 4.8 3 3.2 4.6c-1.6 1.6-1.6 4.2 0 5.8L12 19.2l8.8-8.8c1.6-1.6 1.6-4.2 0-5.8Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                        </svg>
                                    </button>
                                </div>

                                <div className="absolute left-4 top-4 flex items-center gap-2">
                                    {(s["badge"] or "") and (
                                        <div className="px-3 py-1 rounded-full text-xs font-semibold shadow-soft" style={{"backgroundColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}>
                                            {s["badge"]}
                                        </div>
                                    )}
                                    <div className="px-3 py-1 rounded-full text-xs font-semibold text-white" style={{"backgroundColor": "rgba(7,20,39,0.72)", "border": "1px solid rgba(255,255,255,0.18)"}}>
                                        {s["type"]}
                                    </div>
                                </div>

                                <div className="absolute left-5 bottom-5">
                                    <div className="text-white text-3xl leading-none" style={{"fontFamily": "var(--font-display)"}}>{s["title"]}</div>
                                    <div className="mt-2 inline-flex items-center gap-2 text-white/85 text-sm">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                            <path d="M12 22s8-4 8-10V6l-8-4-8 4v6c0 6 8 10 8 10Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                        </svg>
                                        <span>{s["location"]}</span>
                                    </div>
                                </div>
                            </div>

                            <div className="px-6 py-6">
                                <div className="flex items-start justify-between gap-4">
                                    <div className="flex flex-wrap gap-2">
                                        {[
                                            <span key={f} className="px-3 py-1 rounded-full text-xs border" style={{"backgroundColor": "rgba(255,255,255,0.65)", "borderColor": "rgba(7,20,39,0.10)", "color": "rgba(7,20,39,0.75)"}}>
                                                {f}
                                            </span>
                                            for f in (s["features"] or [])
                                        ]}
                                    </div>

                                    <div className="shrink-0 text-right">
                                        <div className="inline-flex items-center gap-1 text-sm font-semibold" style={{"color": "rgba(7,20,39,0.85)"}}>
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <path d="M12 17.3l-6.2 3.7 1.7-7.1L2 9.2l7.2-.6L12 2l2.8 6.6 7.2.6-5.5 4.7 1.7 7.1L12 17.3Z" />
                                            </svg>
                                            <span>{s["rating"]}</span>
                                            <span className="text-xs font-normal text-muted-foreground">({s["reviews"]})</span>
                                        </div>
                                    </div>
                                </div>

                                <div className="mt-6 flex items-center justify-between gap-4">
                                    <div className="text-lg font-semibold" style={{"fontFamily": "var(--font-display)", "color": "rgba(7,20,39,0.92)"}}>
                                        {s["price"]}
                                    </div>
                                    <button
                                        type="button"
                                        onClick={lambda e: open_booking(s)}
                                        className="h-11 px-5 rounded-full text-sm font-semibold shadow-soft border hover:opacity-95 transition-opacity"
                                        style={{"backgroundColor": "var(--color-gold)", "borderColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                                    >
                                        Book Now
                                    </button>
                                </div>
                            </div>
                        </div>
                        for s in filtered
                    ]}
                </div>
            </section>

            <footer className="w-full" style={{"backgroundColor": "rgba(7,20,39,0.98)", "color": "rgba(255,255,255,0.86)"}}>
                <div className="max-w-6xl mx-auto px-4 py-14">
                    <div className="grid grid-cols-1 md:grid-cols-12 gap-10">
                        <div className="md:col-span-4">
                            <div className="text-2xl" style={{"fontFamily": "var(--font-display)", "color": "white"}}>SwissEscape</div>
                            <p className="mt-4 text-sm leading-relaxed" style={{"color": "rgba(255,255,255,0.72)"}}>
                                Switzerland's premium travel marketplace. Discover curated local experiences, scenic journeys, and luxury stays.
                            </p>
                            <div className="mt-6 flex items-center gap-3">
                                <a href="#" className="h-10 w-10 rounded-xl border flex items-center justify-center hover:bg-white/5 transition-colors" style={{"borderColor": "rgba(255,255,255,0.14)", "color": "rgba(255,255,255,0.85)"}} aria-label="Instagram">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="3" y="3" width="18" height="18" rx="5" stroke="currentColor" strokeWidth="2" />
                                        <circle cx="12" cy="12" r="4" stroke="currentColor" strokeWidth="2" />
                                        <circle cx="17.5" cy="6.5" r="1" fill="currentColor" />
                                    </svg>
                                </a>
                                <a href="#" className="h-10 w-10 rounded-xl border flex items-center justify-center hover:bg-white/5 transition-colors" style={{"borderColor": "rgba(255,255,255,0.14)", "color": "rgba(255,255,255,0.85)"}} aria-label="Facebook">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M14 8h3V5h-3c-2.2 0-4 1.8-4 4v3H7v3h3v7h3v-7h3l1-3h-4V9c0-.6.4-1 1-1Z" fill="currentColor" />
                                    </svg>
                                </a>
                                <a href="#" className="h-10 w-10 rounded-xl border flex items-center justify-center hover:bg-white/5 transition-colors" style={{"borderColor": "rgba(255,255,255,0.14)", "color": "rgba(255,255,255,0.85)"}} aria-label="Twitter">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 7.5c-.6.3-1.2.4-1.9.5.7-.4 1.2-1 1.4-1.8-.6.4-1.3.7-2.1.8-.6-.6-1.4-1-2.3-1-1.8 0-3.2 1.5-3.2 3.3 0 .3 0 .6.1.8-2.7-.1-5.1-1.5-6.7-3.6-.3.6-.4 1.2-.4 1.9 0 1.1.5 2.1 1.4 2.7-.5 0-1-.2-1.5-.4v.1c0 1.6 1.1 2.9 2.6 3.2-.3.1-.6.1-.9.1-.2 0-.4 0-.6-.1.4 1.4 1.7 2.4 3.2 2.4-1.2 1-2.7 1.6-4.3 1.6H4c1.6 1 3.5 1.6 5.6 1.6 6.7 0 10.4-5.7 10.4-10.6v-.5c.7-.5 1.2-1.1 1.7-1.8Z" fill="currentColor" />
                                    </svg>
                                </a>
                            </div>
                        </div>

                        <div className="md:col-span-2">
                            <div className="text-xs uppercase tracking-[0.16em]" style={{"color": "rgba(255,255,255,0.7)"}}>Explore</div>
                            <div className="mt-4 flex flex-col gap-2">
                                <Link to="/destinations" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Destinations</Link>
                                <Link to="/experiences" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Experiences</Link>
                                <Link to="/stays" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Stays</Link>
                                <Link to="/dashboard" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Dashboard</Link>
                            </div>
                        </div>

                        <div className="md:col-span-2">
                            <div className="text-xs uppercase tracking-[0.16em]" style={{"color": "rgba(255,255,255,0.7)"}}>Company</div>
                            <div className="mt-4 flex flex-col gap-2">
                                <Link to="/about" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>About Us</Link>
                                <Link to="/host" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Become a Host</Link>
                                <Link to="/careers" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Careers</Link>
                                <Link to="/press" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Press</Link>
                                <Link to="/contact" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Contact</Link>
                            </div>
                        </div>

                        <div className="md:col-span-4">
                            <div className="text-xs uppercase tracking-[0.16em]" style={{"color": "rgba(255,255,255,0.7)"}}>Newsletter</div>
                            <p className="mt-4 text-sm leading-relaxed" style={{"color": "rgba(255,255,255,0.72)"}}>
                                Get travel inspiration and exclusive deals delivered to your inbox.
                            </p>
                            <div className="mt-5 flex gap-2">
                                <input
                                    className="flex-1 h-11 rounded-2xl px-4 text-sm outline-none"
                                    style={{"backgroundColor": "rgba(255,255,255,0.08)", "border": "1px solid rgba(255,255,255,0.14)", "color": "rgba(255,255,255,0.9)"}}
                                    placeholder="Email address"
                                />
                                <button
                                    className="h-11 w-11 rounded-2xl inline-flex items-center justify-center border hover:opacity-95 transition-opacity"
                                    style={{"backgroundColor": "var(--color-gold)", "borderColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                                    aria-label="Submit"
                                    type="button"
                                >
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M22 2L11 13" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                        <path d="M22 2L15 22l-4-9-9-4 20-7Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div className="mt-12 pt-6 border-t flex flex-col md:flex-row md:items-center md:justify-between gap-3 text-xs" style={{"borderColor": "rgba(255,255,255,0.12)", "color": "rgba(255,255,255,0.65)"}}>
                        <div>© 2026 SwissEscape. All rights reserved.</div>
                        <div className="flex gap-4">
                            <a href="#" className="hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.65)"}}>Privacy</a>
                            <a href="#" className="hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.65)"}}>Terms</a>
                            <a href="#" className="hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.65)"}}>Cookies</a>
                        </div>
                    </div>
                </div>
            </footer>

            {bookingOpen and (
                step1_modal() if bookingStep == 1 else (step2_modal() if bookingStep == 2 else step3_modal())
            )}
            {toastOpen and toast()}
        </div>
    );
}
