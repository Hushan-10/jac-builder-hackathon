import from "@jac/runtime" { Link }


def:pub page() -> JsxElement {
    has activeTab: str = "Upcoming";

    tabs = [
        {"key": "Upcoming", "label": "Upcoming"},
        {"key": "Completed", "label": "Completed"},
        {"key": "Wishlist", "label": "Wishlist"},
        {"key": "Messages", "label": "Messages"},
        {"key": "My Reviews", "label": "My Reviews"},
        {"key": "Settings", "label": "Settings"}
    ];

    trips = [
        {
            "id": "SE-ABC123",
            "status": "confirmed",
            "ref": "SE-ABC123",
            "title": "Zermatt Matterhorn Guided Day Tour",
            "date": "2026-04-15",
            "location": "Zermatt",
            "duration": "8 hours",
            "image": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "SE-DEF456",
            "status": "confirmed",
            "ref": "SE-DEF456",
            "title": "Glacier Express Scenic Journey",
            "date": "2026-04-22",
            "location": "Zermatt – St. Moritz",
            "duration": "8 hours",
            "image": "https://images.unsplash.com/photo-1521295121783-8a321d551ad2?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "SE-GHI789",
            "status": "confirmed",
            "ref": "SE-GHI789",
            "title": "Lucerne Lake Cruise Experience",
            "date": "2026-05-01",
            "location": "Lucerne",
            "duration": "4 hours",
            "image": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80"
        }
    ];

    completed_trips = [
        {
            "id": "SE-COMP001",
            "title": "Lucerne Lake Cruise Experience",
            "date": "2026-03-10",
            "guests": "3 guests",
            "image": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "SE-COMP002",
            "title": "Swiss Chocolate & Culture Tour",
            "date": "2026-02-18",
            "guests": "2 guests",
            "image": "https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba?auto=format&fit=crop&w=1600&q=80"
        }
    ];

    wishlist = [
        {
            "id": "SE-WISH001",
            "title": "Zermatt Matterhorn Guided Day Tour",
            "location": "Zermatt",
            "price": "CHF 189",
            "image": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "SE-WISH002",
            "title": "Interlaken Adventure Pass",
            "location": "Interlaken",
            "price": "CHF 249",
            "image": "https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "SE-WISH003",
            "title": "Lucerne Lake Cruise Experience",
            "location": "Lucerne",
            "price": "CHF 89",
            "image": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "SE-WISH004",
            "title": "Glacier Express Scenic Journey",
            "location": "Zermatt – St. Moritz",
            "price": "CHF 329",
            "image": "https://images.unsplash.com/photo-1521295121783-8a321d551ad2?auto=format&fit=crop&w=1600&q=80"
        }
    ];

    messages = [
        {
            "id": "SE-MSG001",
            "sender": "Anna M.",
            "role": "Guide",
            "topic": "Zermatt Matterhorn Guided Day Tour",
            "preview": "Looking forward to hosting you next week...",
            "time": "2h ago"
        },
        {
            "id": "SE-MSG002",
            "sender": "Alpine Chalet Team",
            "role": "Host",
            "topic": "Alpine Luxury Chalet",
            "preview": "Your late check-in request has been confirmed.",
            "time": "Yesterday"
        },
        {
            "id": "SE-MSG003",
            "sender": "Lucas R.",
            "role": "Guide",
            "topic": "Glacier Express Scenic Journey",
            "preview": "Please arrive at the station 20 minutes early.",
            "time": "2 days ago"
        }
    ];

    reviews = [
        {
            "id": "SE-REV001",
            "experience": "Glacier Express Scenic Journey",
            "rating": 5,
            "text": "Absolutely magical journey with stunning views and seamless organization.",
            "date": "2026-03-15"
        },
        {
            "id": "SE-REV002",
            "experience": "Lucerne Lake Cruise Experience",
            "rating": 4,
            "text": "Beautiful scenery and relaxing atmosphere. Highly recommended.",
            "date": "2026-03-11"
        }
    ];

    has settings_name: str = "Hushan";
    has settings_email: str = "alex@example.com";
    has settings_phone: str = "+41 79 123 45 10";
    has settings_style: str = "Luxury / Adventure";
    has settings_newsletter: bool = True;

    has settings_error: str = "";
    has settings_success: str = "";
    has settings_saving: bool = False;

    def set_tab(k: str) -> None {
        activeTab = k;
    }

    def click_upcoming() -> None { set_tab("Upcoming"); }
    def click_completed() -> None { set_tab("Completed"); }
    def click_wishlist() -> None { set_tab("Wishlist"); }
    def click_messages() -> None { set_tab("Messages"); }
    def click_reviews() -> None { set_tab("My Reviews"); }
    def click_settings() -> None { set_tab("Settings"); }

    def tab_onclick(k: str) -> object {
        return (
            click_upcoming if k == "Upcoming"
            else click_completed if k == "Completed"
            else click_wishlist if k == "Wishlist"
            else click_messages if k == "Messages"
            else click_reviews if k == "My Reviews"
            else click_settings
        );
    }

    def tab_class(is_active: bool) -> str {
        return (
            "h-10 px-4 rounded-full text-[13px] font-medium border inline-flex items-center gap-1.5 whitespace-nowrap transition-colors "
            + (
                "bg-[#071427] text-white border-[#071427] shadow-soft"
                    if is_active
                    else "bg-white/70 text-foreground/70 border-border hover:text-foreground"
            )
        );
    }

    def status_badge() -> JsxElement {
        return (
            <span className="px-3 py-1 rounded-full text-xs font-semibold" style={{"backgroundColor": "rgba(34,197,94,0.12)", "color": "rgba(22,101,52,0.95)", "border": "1px solid rgba(34,197,94,0.22)"}}>
                confirmed
            </span>
        );
    }

    def trip_card(t: dict) -> JsxElement {
        img = str(t["image"] or "");
        return (
            <div className="bg-white/70 border border-border rounded-[var(--radius-xl)] shadow-soft overflow-hidden">
                <div className="p-4 md:p-5">
                    <div className="flex flex-col md:flex-row gap-4 md:gap-5">
                        <div className="w-full md:w-[240px]">
                            <div className="h-40 md:h-36 w-full rounded-2xl bg-cover bg-center" style={{"backgroundImage": "url(" + img + ")"}} />
                        </div>

                        <div className="flex-1">
                            <div className="flex items-start justify-between gap-4">
                                <div className="flex items-center gap-3">
                                    {status_badge()}
                                    <div className="text-xs font-semibold tracking-[0.14em] uppercase" style={{"color": "rgba(7,20,39,0.55)"}}>
                                        {t["ref"]}
                                    </div>
                                </div>
                            </div>

                            <div className="mt-2.5 text-xl md:text-2xl leading-tight" style={{"fontFamily": "var(--font-display)", "color": "rgba(7,20,39,0.92)"}}>
                                {t["title"]}
                            </div>

                            <div className="mt-2.5 flex flex-wrap items-center gap-x-4 gap-y-1.5 text-[13px]" style={{"color": "rgba(7,20,39,0.62)"}}>
                                <div className="inline-flex items-center gap-2">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.55)"}}>
                                        <path d="M8 7V3m8 4V3M4 11h16M6 5h12a2 2 0 0 1 2 2v13a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                    </svg>
                                    <span>{t["date"]}</span>
                                </div>
                                <div className="inline-flex items-center gap-2">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.55)"}}>
                                        <path d="M12 21s-7-4.4-7-11a7 7 0 1 1 14 0c0 6.6-7 11-7 11z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                        <circle cx="12" cy="10" r="2.5" stroke="currentColor" strokeWidth="2" />
                                    </svg>
                                    <span>{t["location"]}</span>
                                </div>
                                <div className="inline-flex items-center gap-2">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.55)"}}>
                                        <path d="M12 6v6l4 2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                        <circle cx="12" cy="12" r="9" stroke="currentColor" strokeWidth="2" />
                                    </svg>
                                    <span>{t["duration"]}</span>
                                </div>
                            </div>

                            <div className="mt-4 flex flex-wrap items-center gap-2.5">
                                <button
                                    type="button"
                                    className="h-10 px-4 rounded-full text-[13px] font-semibold shadow-soft border"
                                    style={{"backgroundColor": "#071427", "borderColor": "#071427", "color": "white"}}
                                >
                                    View Details
                                </button>
                                <button
                                    type="button"
                                    className="h-10 px-4 rounded-full text-[13px] font-semibold shadow-soft border"
                                    style={{"backgroundColor": "rgba(255,255,255,0.75)", "borderColor": "rgba(7,20,39,0.10)", "color": "rgba(7,20,39,0.85)"}}
                                >
                                    Contact Guide
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    def completed_card(t: dict) -> JsxElement {
        img = str(t["image"] or "");
        return (
            <div className="bg-white/70 border border-border rounded-[var(--radius-xl)] shadow-soft overflow-hidden">
                <div className="p-4 md:p-5">
                    <div className="flex flex-col md:flex-row gap-4 md:gap-5">
                        <div className="w-full md:w-[240px]">
                            <div className="h-40 md:h-36 w-full rounded-2xl bg-cover bg-center" style={{"backgroundImage": "url(" + img + ")"}} />
                        </div>

                        <div className="flex-1">
                            <div className="text-xl md:text-2xl leading-tight" style={{"fontFamily": "var(--font-display)", "color": "rgba(7,20,39,0.92)"}}>
                                {t["title"]}
                            </div>
                            <div className="mt-2 text-[13px]" style={{"color": "rgba(7,20,39,0.62)"}}>
                                {t["date"]} · {t["guests"]}
                            </div>

                            <div className="mt-4">
                                <button
                                    type="button"
                                    className="h-10 px-4 rounded-full text-[13px] font-semibold shadow-soft border inline-flex items-center gap-2"
                                    style={{"backgroundColor": "rgba(255,255,255,0.75)", "borderColor": "rgba(7,20,39,0.10)", "color": "rgba(7,20,39,0.88)"}}
                                >
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.75)"}}>
                                        <path d="M12 17.3l-6.2 3.3 1.2-7-5-4.9 7-1 3-6.4 3 6.4 7 1-5 4.9 1.2 7L12 17.3Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                    </svg>
                                    Leave Review
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    def wishlist_card(w: dict) -> JsxElement {
        img = str(w["image"] or "");
        return (
            <div className="bg-white/70 border border-border rounded-[var(--radius-xl)] shadow-soft overflow-hidden">
                <div className="relative">
                    <div className="h-44 w-full bg-cover bg-center" style={{"backgroundImage": "url(" + img + ")"}} />
                    <div className="absolute top-3 right-3 h-9 w-9 rounded-full flex items-center justify-center shadow-soft" style={{"backgroundColor": "rgba(7,20,39,0.92)", "color": "white"}}>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(242,184,75,0.95)"}}>
                            <path d="M12 21s-7-4.4-7-11a4.5 4.5 0 0 1 8-2.8A4.5 4.5 0 0 1 19 10c0 6.6-7 11-7 11Z" />
                        </svg>
                    </div>
                </div>
                <div className="p-4">
                    <div className="text-lg leading-tight" style={{"fontFamily": "var(--font-display)", "color": "rgba(7,20,39,0.92)"}}>
                        {w["title"]}
                    </div>
                    <div className="mt-2 flex items-center justify-between text-[13px]" style={{"color": "rgba(7,20,39,0.62)"}}>
                        <div className="inline-flex items-center gap-2">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(7,20,39,0.55)"}}>
                                <path d="M12 21s-7-4.4-7-11a7 7 0 1 1 14 0c0 6.6-7 11-7 11z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                <circle cx="12" cy="10" r="2.5" stroke="currentColor" strokeWidth="2" />
                            </svg>
                            <span>{w["location"]}</span>
                        </div>
                        <div className="text-sm font-semibold" style={{"color": "rgba(7,20,39,0.86)"}}>{w["price"]}</div>
                    </div>
                </div>
            </div>
        );
    }

    def message_card(m: dict) -> JsxElement {
        return (
            <div className="bg-white/70 border border-border rounded-[var(--radius-xl)] shadow-soft p-4 md:p-5">
                <div className="flex items-start justify-between gap-4">
                    <div>
                        <div className="text-sm font-semibold" style={{"color": "rgba(7,20,39,0.92)"}}>
                            {m["role"]}: {m["sender"]}
                        </div>
                        <div className="mt-1 text-[13px]" style={{"color": "rgba(7,20,39,0.62)"}}>
                            {m["topic"]}
                        </div>
                    </div>
                    <div className="text-xs" style={{"color": "rgba(7,20,39,0.55)"}}>{m["time"]}</div>
                </div>
                <div className="mt-3 text-[13px] leading-relaxed" style={{"color": "rgba(7,20,39,0.72)"}}>
                    “{m["preview"]}”
                </div>
            </div>
        );
    }

    def stars(rating: int) -> JsxElement {
        return (
            <div className="inline-flex items-center gap-1">
                {[
                    <svg key={"s" + str(i)} width="16" height="16" viewBox="0 0 24 24" fill={("rgba(242,184,75,0.95)" if i <= rating else "rgba(7,20,39,0.18)")} xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 17.3l-6.2 3.3 1.2-7-5-4.9 7-1 3-6.4 3 6.4 7 1-5 4.9 1.2 7L12 17.3Z" />
                    </svg>
                    for i in range(1, 6)
                ]}
            </div>
        );
    }

    def review_card(r: dict) -> JsxElement {
        rating = int(r["rating"] or 0);
        return (
            <div className="bg-white/70 border border-border rounded-[var(--radius-xl)] shadow-soft p-4 md:p-5">
                <div className="flex items-center justify-between gap-4">
                    {stars(rating)}
                    <div className="text-xs" style={{"color": "rgba(7,20,39,0.55)"}}>{r["date"]}</div>
                </div>
                <div className="mt-3 text-lg leading-tight" style={{"fontFamily": "var(--font-display)", "color": "rgba(7,20,39,0.92)"}}>
                    {r["experience"]}
                </div>
                <div className="mt-2 text-[13px] leading-relaxed" style={{"color": "rgba(7,20,39,0.72)"}}>
                    “{r["text"]}”
                </div>
            </div>
        );
    }

    def handle_settings_name(e: any) -> None { settings_name = e["target"]["value"]; settings_success = ""; }
    def handle_settings_email(e: any) -> None { settings_email = e["target"]["value"]; settings_success = ""; }
    def handle_settings_phone(e: any) -> None { settings_phone = e["target"]["value"]; settings_success = ""; }
    def handle_settings_style(e: any) -> None { settings_style = e["target"]["value"]; settings_success = ""; }
    def toggle_newsletter() -> None { settings_newsletter = not settings_newsletter; settings_success = ""; }

    def is_valid_email(x: str) -> bool {
        v = str(x or "").strip();
        return v.includes("@") and v.includes(".") and (len(v) >= 5);
    }

    async def save_settings() -> None {
        settings_success = "";
        settings_error = "";

        name_v = str(settings_name or "").strip();
        email_v = str(settings_email or "").strip();
        phone_v = str(settings_phone or "").strip();
        style_v = str(settings_style or "").strip();

        if not name_v {
            settings_error = "Full Name is required.";
            return;
        }
        if not email_v {
            settings_error = "Email is required.";
            return;
        }
        if not is_valid_email(email_v) {
            settings_error = "Please enter a valid email address.";
            return;
        }
        if not phone_v {
            settings_error = "Phone is required.";
            return;
        }
        if not style_v {
            settings_error = "Preferred Travel Style is required.";
            return;
        }

        settings_saving = True;
        # Save immediately (client-safe)
        settings_saving = False;

        settings_name = name_v;
        settings_email = email_v;
        settings_phone = phone_v;
        settings_style = style_v;

        settings_success = "Settings saved successfully";
    }

    def settings_panel() -> JsxElement {
        return (
            <div className="bg-white/70 border border-border rounded-[var(--radius-xl)] shadow-soft p-5 md:p-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <div className="text-xs font-semibold tracking-[0.14em] uppercase" style={{"color": "rgba(7,20,39,0.55)"}}>Full Name</div>
                        <input
                            value={settings_name}
                            onChange={handle_settings_name}
                            className="mt-2 h-11 w-full rounded-2xl px-4 text-sm outline-none border"
                            style={{"backgroundColor": "rgba(255,255,255,0.75)", "borderColor": "rgba(7,20,39,0.10)", "color": "rgba(7,20,39,0.9)"}}
                        />
                    </div>
                    <div>
                        <div className="text-xs font-semibold tracking-[0.14em] uppercase" style={{"color": "rgba(7,20,39,0.55)"}}>Email</div>
                        <input
                            value={settings_email}
                            onChange={handle_settings_email}
                            className="mt-2 h-11 w-full rounded-2xl px-4 text-sm outline-none border"
                            style={{"backgroundColor": "rgba(255,255,255,0.75)", "borderColor": "rgba(7,20,39,0.10)", "color": "rgba(7,20,39,0.9)"}}
                        />
                    </div>
                    <div>
                        <div className="text-xs font-semibold tracking-[0.14em] uppercase" style={{"color": "rgba(7,20,39,0.55)"}}>Phone</div>
                        <input
                            value={settings_phone}
                            onChange={handle_settings_phone}
                            className="mt-2 h-11 w-full rounded-2xl px-4 text-sm outline-none border"
                            style={{"backgroundColor": "rgba(255,255,255,0.75)", "borderColor": "rgba(7,20,39,0.10)", "color": "rgba(7,20,39,0.9)"}}
                        />
                    </div>
                    <div>
                        <div className="text-xs font-semibold tracking-[0.14em] uppercase" style={{"color": "rgba(7,20,39,0.55)"}}>Preferred Travel Style</div>
                        <input
                            value={settings_style}
                            onChange={handle_settings_style}
                            className="mt-2 h-11 w-full rounded-2xl px-4 text-sm outline-none border"
                            style={{"backgroundColor": "rgba(255,255,255,0.75)", "borderColor": "rgba(7,20,39,0.10)", "color": "rgba(7,20,39,0.9)"}}
                        />
                    </div>
                </div>

                <div className="mt-5 flex items-center justify-between gap-4">
                    <div>
                        <div className="text-xs font-semibold tracking-[0.14em] uppercase" style={{"color": "rgba(7,20,39,0.55)"}}>Newsletter</div>
                        <div className="mt-1 text-[13px]" style={{"color": "rgba(7,20,39,0.62)"}}>Get curated SwissEscape updates and offers.</div>
                    </div>
                    <button
                        type="button"
                        onClick={toggle_newsletter}
                        className="h-10 px-4 rounded-full text-[13px] font-semibold shadow-soft border"
                        style={{"backgroundColor": ("#071427" if settings_newsletter else "rgba(255,255,255,0.75)"), "borderColor": ("#071427" if settings_newsletter else "rgba(7,20,39,0.10)"), "color": ("white" if settings_newsletter else "rgba(7,20,39,0.85)")}}
                    >
                        {"Enabled" if settings_newsletter else "Disabled"}
                    </button>
                </div>

                {settings_error and (
                    <div className="mt-5 rounded-2xl border px-4 py-3 text-sm" style={{"backgroundColor": "rgba(220,38,38,0.06)", "borderColor": "rgba(220,38,38,0.18)", "color": "rgba(153,27,27,0.92)"}}>
                        {settings_error}
                    </div>
                )}

                {settings_success and (
                    <div className="mt-5 rounded-2xl border px-4 py-3 text-sm" style={{"backgroundColor": "rgba(34,197,94,0.08)", "borderColor": "rgba(34,197,94,0.22)", "color": "rgba(21,128,61,0.92)"}}>
                        {settings_success}
                    </div>
                )}

                <div className="mt-6">
                    <button
                        type="button"
                        onClick={save_settings}
                        disabled={settings_saving}
                        className="h-11 px-6 rounded-full text-sm font-semibold shadow-soft border"
                        style={{"backgroundColor": "var(--color-gold)", "borderColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)", "opacity": (0.75 if settings_saving else 1), "cursor": ("not-allowed" if settings_saving else "pointer")}}
                    >
                        {"Saving..." if settings_saving else "Save Changes"}
                    </button>
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
                            <Link to="/stays" className="hover:text-foreground transition-colors">Stays</Link>
                            <Link to="/dashboard" className="text-foreground hover:text-foreground transition-colors">Dashboard</Link>
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

            <header className="py-9 md:py-10" style={{"backgroundColor": "#0B2A4A"}}>
                <div className="max-w-6xl mx-auto px-4">
                    <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
                        <div className="flex items-center gap-4">
                            <div className="h-12 w-12 rounded-full flex items-center justify-center" style={{"border": "2px solid rgba(242,184,75,0.55)", "backgroundColor": "rgba(255,255,255,0.06)"}}>
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(242,184,75,0.95)"}}>
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                    <path d="M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                </svg>
                            </div>
                            <div>
                                <div className="text-3xl md:text-4xl text-white leading-[1.08]" style={{"fontFamily": "var(--font-display)"}}>
                                    Welcome back, Traveler
                                </div>
                                <div className="mt-1.5 text-sm md:text-sm" style={{"color": "rgba(255,255,255,0.72)"}}>
                                    3 upcoming trips · 5 wishlisted experiences
                                </div>
                            </div>
                        </div>

                        <button
                            type="button"
                            className="h-10 px-4 rounded-full text-[13px] font-semibold border shadow-soft self-start md:self-auto"
                            style={{"backgroundColor": "rgba(255,255,255,0.10)", "borderColor": "rgba(255,255,255,0.18)", "color": "rgba(255,255,255,0.92)"}}
                        >
                            Quick Action
                        </button>
                    </div>
                </div>
            </header>

            <section className="bg-white/60 border-b border-border">
                <div className="max-w-6xl mx-auto px-4 py-4.5">
                    <div className="flex items-center gap-2 overflow-x-auto">
                        {[
                            <button
                                key={t["key"]}
                                type="button"
                                onClick={tab_onclick(t["key"])}
                                className={tab_class(t["key"] == activeTab)}
                            >
                                {t["label"]}
                            </button>
                            for t in tabs
                        ]}
                    </div>
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 py-10 md:py-12">
                <div className="flex items-end justify-between gap-4">
                    <div className="text-2xl md:text-3xl" style={{"fontFamily": "var(--font-display)", "color": "rgba(7,20,39,0.92)"}}>
                        {(
                            "Upcoming Trips" if activeTab == "Upcoming"
                            else "Completed Trips" if activeTab == "Completed"
                            else "Saved Experiences" if activeTab == "Wishlist"
                            else "Messages" if activeTab == "Messages"
                            else "My Reviews" if activeTab == "My Reviews"
                            else "Account Settings"
                        )}
                    </div>
                </div>

                <div className="mt-6">
                    {(activeTab == "Upcoming") and (
                        <div className="flex flex-col gap-5">
                            {[trip_card(t) for t in trips]}
                        </div>
                    ) or (activeTab == "Completed") and (
                        <div className="flex flex-col gap-5">
                            {[completed_card(t) for t in completed_trips]}
                        </div>
                    ) or (activeTab == "Wishlist") and (
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
                            {[wishlist_card(w) for w in wishlist]}
                        </div>
                    ) or (activeTab == "Messages") and (
                        <div className="flex flex-col gap-4">
                            {[message_card(m) for m in messages]}
                        </div>
                    ) or (activeTab == "My Reviews") and (
                        <div className="flex flex-col gap-4">
                            {[review_card(r) for r in reviews]}
                        </div>
                    ) or (
                        {settings_panel()}
                    )}
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
        </div>
    );
}
