import from "@jac/runtime" { Link }


def:pub page() -> JsxElement {
    destinations = [
        {
            "name": "Zermatt",
            "tagline": "Home of the Matterhorn",
            "badge": "24 experiences",
            "season": "Dec–Mar (Ski) / Jun–Sep (Hike)",
            "desc": "A car-free alpine village at the foot of the iconic Matterhorn, offering world-class skiing, hiking, and cozy chalets.",
            "img": "https://images.unsplash.com/photo-1521295121783-8a321d551ad2?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "name": "Interlaken",
            "tagline": "Adventure Capital of Switzerland",
            "badge": "32 experiences",
            "season": "Year-round",
            "desc": "Nestled between Lake Thun and Lake Brienz, Interlaken is the gateway to the Jungfrau region and unforgettable mountain views.",
            "img": "https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "name": "Lucerne",
            "tagline": "The Heart of Switzerland",
            "badge": "28 experiences",
            "season": "Apr–Oct",
            "desc": "A picturesque city on Lake Lucerne with a perfectly preserved medieval old town, iconic bridges, and lakeside promenades.",
            "img": "https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "name": "Zurich",
            "tagline": "Culture Meets Alpine Charm",
            "badge": "22 experiences",
            "season": "Year-round",
            "desc": "Switzerland's largest city blends cosmopolitan culture, world-class dining, and lakefront living with easy access to alpine escapes.",
            "img": "https://images.unsplash.com/photo-1520967824495-b529aeba26df?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "name": "Geneva",
            "tagline": "The Swiss Riviera Gateway",
            "badge": "18 experiences",
            "season": "May–Oct",
            "desc": "An international city on Lake Geneva surrounded by vineyards, offering cultural richness, luxury lakeside promenades, and mountain views.",
            "img": "https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb?auto=format&fit=crop&w=2400&q=80"
        },
        {
            "name": "Grindelwald",
            "tagline": "Village at the Foot of the Eiger",
            "badge": "20 experiences",
            "season": "Jun–Sep / Dec–Mar",
            "desc": "A charming mountain village offering dramatic Eiger views, the First cliff walk, and access to iconic Jungfrau-region trails.",
            "img": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=2400&q=80&crop=entropy"
        }
    ];

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
                            <Link to="/destinations" className="text-foreground hover:text-foreground transition-colors">Destinations</Link>
                            <Link to="/experiences" className="hover:text-foreground transition-colors">Experiences</Link>
                            <Link to="/stays" className="hover:text-foreground transition-colors">Stays</Link>
                            <Link to="/itinerary" className="hover:text-foreground transition-colors">AI Planner</Link>
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
                            SWISS DESTINATIONS
                        </div>
                        <h1 className="mt-5 text-5xl md:text-6xl text-white leading-[1.02]" style={{"fontFamily": "var(--font-display)"}}>
                            Explore Switzerland
                        </h1>
                        <p className="mt-5 max-w-3xl mx-auto text-base md:text-lg leading-relaxed text-white/80">
                            From snow-capped peaks to lakeside gems — discover the best destinations across Switzerland.
                        </p>
                    </div>
                </div>
            </header>

            <section className="max-w-6xl mx-auto px-4 py-14 md:py-18">
                <div className="grid grid-cols-1 md:grid-cols-3 gap-7">
                    {[
                        <div key={d["name"]} className="group rounded-[var(--radius-xl)] bg-white/70 border border-border shadow-soft hover:shadow-card transition-[box-shadow,transform] duration-300 hover:-translate-y-1 overflow-hidden">
                            <Link to="/destinations" className="block">
                                <div className="relative overflow-hidden rounded-[var(--radius-xl)]">
                                    <div className="h-64 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]" style={{"backgroundImage": "url(" + d["img"] + ")"}} />
                                    <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/15 to-black/0" />

                                    <div className="absolute top-4 right-4">
                                        <div className="px-4 py-2 rounded-full text-xs font-semibold text-white shadow-soft" style={{"backgroundColor": "var(--color-gold)"}}>
                                            <span>{d["badge"]}</span>
                                        </div>
                                    </div>

                                    <div className="absolute left-5 bottom-5">
                                        <div className="text-white text-3xl leading-none" style={{"fontFamily": "var(--font-display)"}}><span>{d["name"]}</span></div>
                                        <div className="mt-1 text-white/85 text-sm"><span>{d["tagline"]}</span></div>
                                    </div>
                                </div>
                            </Link>

                            <div className="px-6 py-6">
                                <div className="flex items-center gap-2 text-sm text-muted-foreground">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                        <path d="M12 22s8-4 8-10V6l-8-4-8 4v6c0 6 8 10 8 10Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                    </svg>
                                    <span>{d["season"]}</span>
                                </div>
                                <p className="mt-3 text-sm text-muted-foreground leading-relaxed">
                                    {d["desc"]}
                                </p>
                                <Link to="/experiences" className="mt-4 inline-flex items-center gap-2 text-sm font-medium" style={{"color": "var(--color-gold)"}}>
                                    Explore
                                    <span className="transition-transform duration-200 group-hover:translate-x-0.5">→</span>
                                </Link>
                            </div>
                        </div>
                        for d in destinations
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
                                <Link to="/itinerary" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>AI Planner</Link>
                                <Link to="/guides" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>Travel Guides</Link>
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
